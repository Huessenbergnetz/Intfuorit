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

    SilicaFlickable {
        id: breachSearchFlick

        contentHeight: breachSearchGrid.height

        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                //% "About"
                text: qsTrId("intfuorit-about")
                onClicked: pageStack.push(Qt.resolvedUrl("../../common/pages/About.qml"))
            }
            MenuItem {
                //% "Settings"
                text: qsTrId("intfuorit-settings")
                onClicked: pageStack.push(Qt.resolvedUrl("../../common/pages/Settings.qml"))
            }
            MenuItem {
                //% "Clear result"
                text: qsTrId("intfuorit-clear-result")
                onClicked: {
                    blm.clear()
                    plm.clear()
                    infoText.visible = true
                    noBreachesFound.visible = false
                    noPastesFound.visible = false
                    accountSearch.text = ""
                }
            }
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
                //% "Check account"
                title: qsTrId("intfuorit-check-account-header")
                description: "Have I been pwned?"
                page: breachSearchPage
                Layout.columnSpan: breachSearchGrid.columns
                Layout.fillWidth: true
            }

            SearchField {
                id: accountSearch
                width: parent.width
                inputMethodHints: Qt.ImhEmailCharactersOnly
                EnterKey.onClicked: {
                    if (text.length > 0) {
                        accountSearch.focus = false;
                        infoText.visible = false;
                        noBreachesFound.visible = false
                        noPastesFound.visible = false
                        blm.getBreachesForAccount(accountSearch.text, "", includeUnverified.checked, omitCache.checked)
                        var atPos = text.lastIndexOf("@")
                        var dotPos = text.lastIndexOf(".")
                        if ((atPos > -1) && (dotPos > -1) && (dotPos > atPos) && ((text.length - dotPos + 1) > 1)) {
                            plm.getPastesForAccount(accountSearch.text, omitCache.checked)
                        } else {
                            plm.clear()
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

            TextSwitch {
                id: includeUnverified
                //% "Inlcude unverified breaches"
                text: qsTrId("intfuorit-switch-include-unverified")
                Layout.columnSpan: 1
                Layout.fillWidth: true
            }

            TextSwitch {
                id: omitCache
                //% "Omit local cache"
                text: qsTrId("intfuorit-switch-omit-cache")
                Layout.columnSpan: 1
                Layout.fillWidth: true
            }

            Item {
                id: infoText
                Layout.columnSpan: breachSearchGrid.columns
                Layout.fillWidth: true
                Text {
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                    color: Theme.secondaryColor
                    font.pixelSize: Theme.fontSizeExtraSmall
                    x: Theme.horizontalPageMargin
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    //% "Check if you have an account that has been compromised in a data breach or that is published in a Paste. Simply enter your email address or user name into the search field and start searching."
                    text: qsTrId("intfuorit-check-account-desc")
                }
            }

            BusyIndicator {
                size: BusyIndicatorSize.Large
                Layout.alignment: Qt.AlignCenter
                Layout.columnSpan: breachSearchGrid.columns
                visible: blm.inOperation || plm.inOperation
                running: true
            }

            SectionHeader {
                //% "Breaches you were found in"
                text: qsTrId("intfuorit-section-header-breached-sites")
                Layout.columnSpan: breachSearchGrid.columns
                Layout.preferredWidth: breachSearchGrid.width - Theme.horizontalPageMargin
                visible: breachedSitesRepeater.count > 0
            }

            Item {
                id: noBreachesFound
                Layout.columnSpan: breachSearchGrid.columns
                Layout.fillWidth: true
                Layout.preferredHeight: noBreachesFoundLabel.height + noBreachesFoundText.height
                visible: false

                Label {
                    id: noBreachesFoundLabel
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Theme.highlightColor
                    //% "Good news — no pwnage found!"
                    text: qsTrId("intfuorit-no-pwnage-found-label")
                }

                Text {
                    id: noBreachesFoundText
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; top: noBreachesFoundLabel.bottom }
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Theme.secondaryHighlightColor
                    //% "Your user account is not included in any of the data breach records available on HIBP."
                    text: qsTrId("intfuorit-no-pwnage-found-text")
                }
            }

            Item {
                id: breachesError
                Layout.columnSpan: breachSearchGrid.columns
                Layout.fillWidth: true
                visible: blm.error

                Label {
                    id: breachesErrorLabel
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Theme.highlightColor
                    text: qsTrId("intfuorit-error")
                }

                Text {
                    id: breachesErrorLabelText
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; top: breachesErrorLabel.bottom }
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Theme.secondaryHighlightColor
                    text: blm.error ? blm.error.text : ""
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
                    //% "A <i>breach</i> is an incident where a site's data has been illegally accessed by hackers and then released publicly. Review the types of data that were compromised (email addresses, passwords, credit cards etc.) and take appropriate action, such as changing passwords."
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
                    onGotNoBreachesForAccount: noBreachesFound.visible = true
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
                visible: pastesRepeater.count > 0
            }

            Item {
                id: noPastesFound
                Layout.columnSpan: breachSearchGrid.columns
                Layout.fillWidth: true
                Layout.preferredHeight:noPastesFoundLabel.height + noPastesFoundText.height
                visible: false

                Label {
                    id: noPastesFoundLabel
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Theme.highlightColor
                    //% "Good news — no pastes found!"
                    text: qsTrId("intfuorit-no-pastes-found-label")
                }

                Text {
                    id: noPastesFoundText
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; top: noPastesFoundLabel.bottom }
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Theme.secondaryHighlightColor
                    //% "Your email address is not included in any of the pastes available on HIBP."
                    text: qsTrId("intfuorit-no-pastes-found-text")
                }
            }

            Item {
                id: pastesError
                Layout.columnSpan: breachSearchGrid.columns
                Layout.fillWidth: true
                visible: plm.error

                Label {
                    id: pastesErrorLabel
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Theme.highlightColor
                    text: qsTrId("intfuorit-error")
                }

                Text {
                    id: pastesErrorLabelText
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; top: pastesErrorLabel.bottom }
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Theme.secondaryHighlightColor
                    text: plm.error ? plm.error.text : ""
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
                    onGotNoPastesForAccount: noPastesFound.visible = true
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
                        }

                        Row {
                            width: parent.width
                            Text {
                                width: parent.width/2
                                color: pastesListItem.highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                                font.pixelSize: Theme.fontSizeSmall
                                //% "%1 email(s)"
                                text: qsTrId("intfuorit-emails-in-paste", model.emailCount).arg(model.emailCount.toLocaleString(Qt.locale(), 'f', 0))
                            }

                            Text {
                                width: parent.width/2
                                color: pastesListItem.highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                                font.pixelSize: Theme.fontSizeSmall
                                text: model.date.toLocaleString(Qt.locale(), Locale.ShortFormat)
                                horizontalAlignment: Text.AlignRight
                            }
                        }
                    }
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.columnSpan: breachSearchGrid.columns
                height: Theme.paddingLarge
                visible: pastesRepeater.count > 0
            }
        }
    }
}
