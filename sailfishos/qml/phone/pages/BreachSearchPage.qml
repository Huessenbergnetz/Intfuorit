/* Intfuorit - Qt based client for haveibeenpwned.com
 * Copyright (C) 2017 Hüssenbergnetz/Matthias Fehring
 * https://github.com/Huessenbergnetz/Intfuorit
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.6
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0
import harbour.intfuorit 1.0

Page {
    id: breachSearchPage

    allowedOrientations: Orientation.All

    property bool noPwnedAcc: false
    property bool noPaste: false
    property bool apiInOperation: cpp.inOperation || blm.inOperation || plm.inOperation

    function clear() {
        breachSearchPage.noPaste = false
        breachSearchPage.noPwnedAcc = false
        cpp.clear()
        plm.clear()
        blm.clear()
    }

    CheckPwnedPassword {
        id: cpp
        userAgent: intfuoritUserAgent
    }

    SilicaFlickable {
        id: breachSearchFlick

        contentHeight: breachSearchGrid.height

        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTrId("intfuorit-about")
                onClicked: pageStack.push(Qt.resolvedUrl("../../common/pages/About.qml"))
            }
            MenuItem {
                text: qsTrId("intfuorit-help-faq")
                onClicked: pageStack.push(Qt.resolvedUrl("../../common/pages/Help.qml"))
            }
            MenuItem {
                text: qsTrId("intfuorit-settings")
                onClicked: pageStack.push(Qt.resolvedUrl("../../common/pages/Settings.qml"))
            }
            MenuItem {
                //: Pull down menu entry
                //% "Clear result"
                text: qsTrId("intfuorit-clear-result")
                onClicked: {
                    breachSearchPage.clear()
                    accountSearch.text = ""
                }
            }
        }

        VerticalScrollDecorator {
            flickable: breachSearchFlick
            page: breachSearchPage
        }

        Label {
            id: dummyCount
            visible: false
            text: Number(9999999999).toLocaleString(Qt.locale(), 'f', 0)
            font.pixelSize: Theme.fontSizeSmall
        }

        GridLayout {
            id: breachSearchGrid
            anchors { left: parent.left; right: parent.right; }

            columns: breachSearchPage.isLandscape ? 2 : 1
            columnSpacing: 0

            PageHeader {
                title: searchTarget.currentIndex === 0
                        //: Page header
                        //% "Check account"
                       ? qsTrId("intfuorit-check-account-header")
                        //: Page header
                        //% "Check password"
                       : qsTrId("intfuorit-check-password-header")
                description: "Have I been pwned?"
                page: breachSearchPage
                Layout.columnSpan: breachSearchGrid.columns
                Layout.fillWidth: true
            }

            SearchField {
                id: accountSearch
                width: parent.width
                echoMode: searchTarget.currentIndex === 0 ? TextInput.Normal : TextInput.Password
                inputMethodHints: searchTarget.currentIndex === 0 ? Qt.ImhSensitiveData|Qt.ImhEmailCharactersOnly : Qt.ImhSensitiveData|Qt.ImhNoPredictiveText
                EnterKey.onClicked: {
                    if (text.length > 0) {
                        accountSearch.focus = false;
                        breachSearchPage.clear()
                        if (searchTarget.currentIndex === 0) {
                            blm.getBreachesForAccount(accountSearch.text, "", includeUnverified.checked, omitCache.checked)
                            var atPos = text.lastIndexOf("@")
                            var dotPos = text.lastIndexOf(".")
                            if ((atPos > -1) && (dotPos > -1) && (dotPos > atPos) && ((text.length - dotPos + 1) > 1)) {
                                plm.getPastesForAccount(accountSearch.text, omitCache.checked)
                            }
                        } else {
                            cpp.execute(accountSearch.text, omitCache.checked)
                        }
                    } else {
                        accountSearch.focus = false
                    }
                }
                EnterKey.iconSource: text.length > 0 ? "image://theme/icon-m-search" : "image://theme/icon-m-enter-close"
                EnterKey.enabled: true
                enabled: !blm.inOperation
                Layout.columnSpan: breachSearchGrid.columns
                Layout.fillWidth: true
            }

            Item {
                Layout.columnSpan: breachSearchGrid.columns
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: searchTarget.height
                ComboBox {
                    id: searchTarget
                    //: Label for a combobox (drop down menu), value will be either Account or Password
                    //% "Search for"
                    label: qsTrId("intfuorit-search-for-label")
                    menu: ContextMenu {
                        //: Value for a combobox (drop down menu)
                        //% "Account"
                        MenuItem { text: qsTrId("intfuorit-search-for-account") }
                        //: Value for a combobox (drop down menu)
                        //% "Password"
                        MenuItem { text: qsTrId("intfuorit-search-for-password") }
                    }
                    onCurrentIndexChanged: accountSearch.text = ""
                }
            }

            Item {
                id: infoText
                Layout.columnSpan: breachSearchGrid.columns
                Layout.fillWidth: true
                Layout.preferredHeight: infoTextText.height
                Text {
                    id: infoTextText
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                    color: Theme.secondaryColor
                    font.pixelSize: Theme.fontSizeExtraSmall
                    x: Theme.horizontalPageMargin
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.PlainText
                    text: searchTarget.currentIndex === 0
                          //% "Check if you have an account that has been compromised in a data breach or that is published in a Paste."
                          ? qsTrId("intfuorit-check-account-desc")
                          //% "Check if one of your passwords has previously been exposed in data breaches."
                          : qsTrId("intfuorit-check-password-desc")
                }
            }

            Item {
                Layout.columnSpan: config.cachePeriod > 0 ? 1 : breachSearchGrid.columns
                Layout.fillWidth: true
                Layout.preferredHeight: includeUnverified.height
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                visible: searchTarget.currentIndex === 0
                TextSwitch {
                    id: includeUnverified
                    //: Label on a text switch
                    //% "Include unverified breaches"
                    text: qsTrId("intfuorit-switch-include-unverified")
                    automaticCheck: false
                    checked: config.includeUnverified
                    onClicked: config.includeUnverified = !config.includeUnverified
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: omitCache.height
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.columnSpan: searchTarget.currentIndex === 0 ? 1 : breachSearchGrid.columns
                visible: config.cachePeriod > 0
                TextSwitch {
                    id: omitCache
                    //: Label on a text switch
                    //% "Omit local cache"
                    text: qsTrId("intfuorit-switch-omit-cache")
                    Layout.columnSpan: 1
                }
            }

            Item {
                Layout.columnSpan: breachSearchGrid.columns
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.paddingLarge
            }

            BusyIndicator {
                size: BusyIndicatorSize.Large
                Layout.alignment: Qt.AlignCenter
                Layout.columnSpan: breachSearchGrid.columns
                visible: blm.inOperation || plm.inOperation || cpp.inOperation
                running: true
            }

            Item {
                id: pwned
                Layout.columnSpan: breachSearchGrid.columns
                Layout.fillWidth: true
                Layout.preferredHeight: visible ? (pwnedLabel.height + pwnedPassDesc1.height + pwnedPassDesc2.height + pwndAccDesc.height) : 0
                visible: cpp.count > 0 || breachedSitesRepeater.count > 0 || pastesRepeater.count > 0
                Label {
                    id: pwnedLabel
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; top: parent.top }
                    //% "Oh no — pwned!"
                    text: qsTrId("intfuorit-label-pwned")
                    font.pixelSize: Theme.fontSizeLarge
                    horizontalAlignment: Qt.AlignHCenter
                    color: Theme.highlightColor
                    textFormat: Text.PlainText
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }

                Text {
                    id: pwnedPassDesc1
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; top: pwnedLabel.bottom }
                    visible: cpp.count > 0
                    horizontalAlignment: Qt.AlignHCenter
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeMedium
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.PlainText
                    //% "This password has been seen %n time(s) before."
                    text: qsTrId("intfuorit-pwned-password-count", cpp.count)
                }

                Text {
                    id: pwnedPassDesc2
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; top: pwnedPassDesc1.bottom }
                    visible: cpp.count > 0
                    horizontalAlignment: Qt.AlignHCenter
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.PlainText
                    //% "This password has previously appeared in a data breach and should never be used. If you've ever used it anywhere before, change it!"
                    text: qsTrId("intfuorit-pwned-password-hint")
                }

                Text {
                    id: pwndAccDesc
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; top: pwnedLabel.bottom }
                    visible: breachedSitesRepeater.count > 0 || pastesRepeater.count > 0
                    horizontalAlignment: Qt.AlignHCenter
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: Text.PlainText
                    //% "Pwned on %n breached site(s)."
                    text: qsTrId("intfuorit-pwned-acc-summary", breachedSitesRepeater.count) + " " +
                    //% "Found %n paste(s)."
                    qsTrId("intfuorit-pwned-paste-summary", pastesRepeater.count)
                }
            }

            Item {
                Layout.columnSpan: breachSearchGrid.columns
                Layout.fillWidth: true
                Layout.preferredHeight: visible ? (notPwnedLabel.height + notPwnedDesc.height) : 0
                visible: cpp.count === 0 || (breachSearchPage.noPaste && breachSearchPage.noPwnedAcc)
                Label {
                    id: notPwnedLabel
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; top: parent.top }
                    font.pixelSize: Theme.fontSizeLarge
                    horizontalAlignment: Qt.AlignHCenter
                    color: Theme.secondaryHighlightColor
                    textFormat: Text.PlainText
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    //% "Good news — no pwnage found!"
                    text: qsTrId("intfuorit-label-not-pwned")
                }

                Text {
                    id: notPwnedDesc
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; top: notPwnedLabel.bottom }
                    font.pixelSize: Theme.fontSizeSmall
                    horizontalAlignment: Qt.AlignHCenter
                    color: Theme.secondaryColor
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    textFormat: searchTarget.currentIndex === 0 ? Text.StyledText : Text.PlainText
                    linkColor: Theme.secondaryHighlightColor
                    onLinkActivated: Qt.openUrlExternally(link)
                    text: searchTarget.currentIndex === 0
                          //% "No breached accounts and no pastes (<a href='%1'>subscribe</a> to search sensitive breaches)."
                          ? qsTrId("intfuorit-desc-not-pwned-acc").arg("https://haveibeenpwned.com/NotifyMe")
                          //% "This password wasn't found in any of the Pwned Passwords loaded into Have I Been Pwned. That doesn't necessarily mean it's a good password, merely that it's not indexed on the site."
                          : qsTrId("intfuorit-desc-not-pwned-pass")
                }
            }

            SectionHeader {
                //% "Breaches you were found in"
                text: qsTrId("intfuorit-section-header-breached-sites")
                Layout.columnSpan: breachSearchGrid.columns
                Layout.preferredWidth: breachSearchGrid.width - Theme.horizontalPageMargin
                textFormat: Text.PlainText
                visible: breachedSitesRepeater.count > 0 || breachesError.visible
            }

            Item {
                id: breachesError
                Layout.columnSpan: breachSearchGrid.columns
                Layout.fillWidth: true
                visible: blm.error.type !== Error.NoError

                Label {
                    id: breachesErrorLabel
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Theme.highlightColor
                    textFormat: Text.PlainText
                    text: qsTrId("intfuorit-error")
                }

                Text {
                    id: breachesErrorLabelText
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; top: breachesErrorLabel.bottom }
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Theme.secondaryHighlightColor
                    textFormat: Text.PlainText
                    font.pixelSize: Theme.fontSizeSmall
                    text: blm.error.text
                }
            }

            Item {
                Layout.columnSpan: breachSearchGrid.columns
                Layout.fillWidth: true
                Layout.preferredHeight: breachesDescText.height
                visible: breachedSitesRepeater.count > 0

                Text {
                    id: breachesDescText
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                    //% "A <i>breach</i> is an incident where a site’s data has been illegally accessed by hackers and then released publicly. Review the types of data that were compromised (email addresses, passwords, credit cards etc.) and take appropriate action, such as changing passwords."
                    text: qsTrId("intfuorit-section-desc-breached-sites")
                    color: Theme.secondaryHighlightColor
                    font.pixelSize: Theme.fontSizeExtraSmall
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    x: Theme.horizontalPageMargin
                    textFormat: Text.StyledText
                }
            }

            Repeater {
                id: breachedSitesRepeater
                model: BreachesListModel {
                    id: blm
                    onGotNoBreachesForAccount: breachSearchPage.noPwnedAcc = true
                    userAgent: intfuoritUserAgent
                }
                BreachesListDelegate {
                    countWidth: dummyCount.width
                    Layout.preferredWidth: breachSearchGrid.width / (breachSearchPage.isLandscape ? 2 : 1)
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.columnSpan: breachSearchGrid.columns
                height: Theme.paddingLarge
                visible: breachedSitesRepeater.count > 0
            }

            SectionHeader {
                //% "Pastes you were found in"
                text: qsTrId("intfuorit-section-header-pastes")
                Layout.columnSpan: breachSearchGrid.columns
                Layout.preferredWidth: breachSearchGrid.width - Theme.horizontalPageMargin
                visible: pastesRepeater.count > 0 || pastesError.visible
                textFormat: Text.PlainText
            }

            Item {
                id: pastesError
                Layout.columnSpan: breachSearchGrid.columns
                Layout.fillWidth: true
                visible: plm.error.type !== Error.NoError

                Label {
                    id: pastesErrorLabel
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Theme.highlightColor
                    text: qsTrId("intfuorit-error")
                    textFormat: Text.PlainText
                }

                Text {
                    id: pastesErrorLabelText
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; top: pastesErrorLabel.bottom }
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Theme.secondaryHighlightColor
                    text: plm.error.text
                    textFormat: Text.PlainText
                }
            }

            Item {
                Layout.columnSpan: breachSearchGrid.columns
                Layout.fillWidth: true
                Layout.preferredHeight: pastesDescText.height
                visible: pastesRepeater.count > 0

                Text {
                    id: pastesDescText
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                    //% "A <i>paste</i> is information that has been published to a publicly facing website designed to share content, usually anonymously. Often these are indicators of a data breach so review the paste and determine if your account has been compromised then take appropriate action such as changing passwords. Pastes are often removed shortly after having been posted."
                    text: qsTrId("intfuorit-section-desc-pastes")
                    color: Theme.secondaryHighlightColor
                    font.pixelSize: Theme.fontSizeExtraSmall
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    x: Theme.horizontalPageMargin
                    textFormat: Text.StyledText
                }
            }

            Repeater {
                id: pastesRepeater
                model: PastesListModel {
                    id: plm
                    userAgent: intfuoritUserAgent
                    onGotNoPastesForAccount: breachSearchPage.noPaste = true;
                }
                ListItem {
                    id: pastesListItem
                    Layout.preferredWidth: breachSearchGrid.width / (breachSearchPage.isLandscape ? 2 : 1)
                    height: Theme.itemSizeMedium
                    contentHeight: Theme.itemSizeMedium

                    enabled: model.url.toString() !== ""

                    onClicked: Qt.openUrlExternally(model.url)

                    Column {
                        anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; verticalCenter: parent.verticalCenter }

                        Label {
                            width: parent.width
                            text: model.title
                            font.pixelSize: Theme.fontSizeSmall
                            color: pastesListItem.highlighted ? Theme.highlightColor : Theme.primaryColor
                            truncationMode: TruncationMode.Fade
                            textFormat: Text.PlainText
                        }

                        Row {
                            width: parent.width
                            Text {
                                width: parent.width/2
                                color: pastesListItem.highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                                font.pixelSize: Theme.fontSizeSmall
                                textFormat: Text.StyledText
                                //% "%1 email(s)"
                                text: qsTrId("intfuorit-emails-in-paste", model.emailCount).arg(model.emailCount.toLocaleString(Qt.locale(), 'f', 0))
                            }

                            Text {
                                width: parent.width/2
                                color: pastesListItem.highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                                font.pixelSize: Theme.fontSizeSmall
                                text: model.date.toLocaleString(Qt.locale(), Locale.ShortFormat)
                                horizontalAlignment: Text.AlignRight
                                textFormat: Text.PlainText
                            }
                        }
                    }
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.columnSpan: breachSearchGrid.columns
                height: Theme.paddingLarge
            }

            Item {
                id: hibpAttribution
                Layout.fillWidth: true
                Layout.columnSpan: breachSearchGrid.columns
                height: Theme.itemSizeMedium
                Text {
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; verticalCenter: parent.verticalCenter }
                    color: Theme.secondaryColor
                    font.pixelSize: Theme.fontSizeSmall
                    horizontalAlignment: Text.AlignHCenter
                    textFormat: Text.StyledText
                    text: qsTrId("intfuorit-hibp-attribution").arg("<a href='https://haveibeenpwned.com'>Have I been pwned?</a>")
                    linkColor: Theme.secondaryHighlightColor
                    wrapMode: Text.WordWrap
                    onLinkActivated: Qt.openUrlExternally(link)
                }
            }
        }
    }
}
