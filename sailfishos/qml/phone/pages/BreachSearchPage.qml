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

        Label {
            id: dummyCount
            visible: false
            text: "000,000,000"
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
                        nothingFound.visible = false
                        blm.getBreachesForAccount(accountSearch.text, "", includeUnverified.checked, omitCache.checked)
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
                visible: blm.inOperation
                running: true
            }

            Item {
                id: nothingFound
                Layout.columnSpan: breachSearchGrid.columns
                Layout.fillWidth: true
                Layout.preferredHeight: nothingFoundLabel.height + nothingFoundText.height
                visible: false

                Label {
                    id: nothingFoundLabel
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Theme.highlightColor
                    //% "Good news — no pwnage found!"
                    text: qsTrId("intfuorit-nothing-found-label")
                }

                Text {
                    id: nothingFoundText
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; top: nothingFoundLabel.bottom }
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Theme.secondaryHighlightColor
                    //% "No breached accounts and no pastes."
                    text: qsTrId("intfuorit-nothing-found-text")
                }
            }

            SectionHeader {
                //% "Breaches you were pwned in"
                text: qsTrId("intfuorit-section-header-breached-sites")
                Layout.columnSpan: breachSearchGrid.columns
                Layout.preferredWidth: breachSearchGrid.width - Theme.horizontalPageMargin
                visible: breachedSitesRepeater.count > 0
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
                    onGotNoBreachesForAccount: nothingFound.visible = true
                }
                BreachesListDelegate {
                    countWidth: dummyCount.width
                    width: breachSearchGrid.width / (breachSearchPage.isLandscape ? 2 : 1)
                }
            }
        }
    }
}
