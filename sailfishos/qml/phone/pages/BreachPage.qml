/* Intfuorit - Qt based client for haveibeenpwned.com
 * Copyright (C) 2017-2019 Hüssenbergnetz/Matthias Fehring
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
import Sailfish.Silica 1.0
import harbour.intfuorit 1.0
import de.huessenbergnetz.hbnsc 1.0

Page {
    id: breachPage
    allowedOrientations: Orientation.All

    property alias title: bTitle.title
    property alias domain: bTitle.description
    property alias logoPath: bLogo.source
    property alias pwnCount: bPwnCount.value
    property alias breachDate: bBreachDate.value
    property alias addedDate: bAddedDate.value
    property alias modifiedDate: bModifiedDate.value
    property alias isSensitive: bIsSensitive.visible
    property alias isVerified: bIsVerified.visible
    property alias isFabricated: bIsFrabricated.visible
    property alias isRetired: bIsRetired.visible
    property alias isSpamList: bIsSpamList.visible
    property alias description: bDescription.text
    property alias dataClasses: bDataClasses.text

    SilicaFlickable {
        id: breachPageFlick
        anchors.fill: parent
        contentHeight: breachPageCol.height

        VerticalScrollDecorator {
            flickable: breachPageFlick
            page: breachPage
        }

        Column {
            id: breachPageCol
            width: parent.width

            PageHeader {
                id: bTitle
                page: breachPage
            }

            Image {
                id: bLogo
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                height: Theme.iconSizeExtraLarge
            }

            DetailItem {
                id: bPwnCount
                //% "Affected accounts"
                label: qsTrId("intfuorit-affected-accounts-label")
            }

            DetailItem {
                id: bBreachDate
                //% "Breach date"
                label: qsTrId("intfuorit-breach-date-label")
            }

            DetailItem {
                id: bAddedDate
                //% "Added to HIBP"
                label: qsTrId("intfuorit-added-to-hibp-label")
            }

            DetailItem {
                id: bModifiedDate
                //% "Modified on HIBP"
                label: qsTrId("intfuorit-modified-on-hibp-label")
                visible: value !== bAddedDate.value
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: Theme.paddingLarge

                IconWithHint {
                    id: bIsSensitive
                    icon.source: visible ? "image://intfuorit/icon-m-sensitive-breach" : ""
                    icon.width: Theme.iconSizeMedium; icon.height: icon.width
                    //% "Sensitive breach, not publicly searchable"
                    hintText: qsTrId("intfuorit-sensitive-breach-hint")
                }

                IconWithHint {
                    id: bIsVerified
                    icon.source: visible ? "image://intfuorit/icon-m-unverified-breach" : ""
                    icon.width: Theme.iconSizeMedium; icon.height: icon.width
                    //% "Unverified breach, may be sourced from elsewhere"
                    hintText: qsTrId("intfuorit-unverified-breach-hint")
                }

                IconWithHint {
                    id: bIsFrabricated
                    icon.source: visible ? "image://intfuorit/icon-m-fabricated-breach" : ""
                    icon.width: Theme.iconSizeMedium; icon.height: icon.width
                    //% "Fabricated breach, likely not legitimate"
                    hintText: qsTrId("intfuorit-fabricated-breach-hint")
                }

                IconWithHint {
                    id: bIsRetired
                    icon.source: visible ? "image://intfuorit/icon-m-retired-breach" : ""
                    icon.width: Theme.iconSizeMedium; icon.height: icon.width
                    //% "Retired breach, removed from system"
                    hintText: qsTrId("intfuorit-retired-breach-hint")
                }

                IconWithHint {
                    id: bIsSpamList
                    icon.source: visible ? "image://intfuorit/icon-m-spam-list" : ""
                    icon.width: Theme.iconSizeMedium; icon.height: icon.width
                    //% "Spam list, used for spam marketing"
                    hintText: qsTrId("intfuorit-spam-list-hint")
                }
            }

            SectionHeader {
                //% "Description"
                text: qsTrId("intfuorit-description-label")
            }

            Text {
                id: bDescription
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                textFormat: Text.StyledText
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                linkColor: Theme.highlightColor
                onLinkActivated: Qt.openUrlExternally(link)
            }

            SectionHeader {
                //% "Compromised data"
                text: qsTrId("intfuorit-compromised-data-label")
            }

            Text {
                id: bDataClasses
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                textFormat: Text.StyledText
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }

            Item {
                width: parent.width
                height: Theme.paddingLarge
            }

            Item {
                width: parent.width
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
                }
            }
        }
    }
}
