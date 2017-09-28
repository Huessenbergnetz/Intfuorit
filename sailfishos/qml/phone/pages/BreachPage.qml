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
import Sailfish.Silica 1.0
import harbour.intfuorit 1.0

Page {
    id: breachPage
    allowedOrientations: Orientation.All

    property Breach breach

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
                title: breach.title
                description: breach.domain
                page: breachPage
            }

            Image {
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                source: "https://haveibeenpwned.com/Content/Images/PwnedLogos/" + breach.name + "." + breach.logoType
                fillMode: Image.PreserveAspectFit
            }

            DetailItem {
                //% "Affected accounts"
                label: qsTrId("intfuorit-affected-accounts-label")
                value: breach.pwnCount.toLocaleString(Qt.locale(), 'f', 0)
            }

            DetailItem {
                //% "Breach date"
                label: qsTrId("intfuorit-breach-date-label")
                value: breach.breachDate.toLocaleDateString(Qt.locale(), Locale.ShortFormat)
            }

            DetailItem {
                //% "Added to HIBP"
                label: qsTrId("intfuorit-added-to-hibp-label")
                value: breach.addedDate.toLocaleString(Qt.locale(), Locale.ShortFormat)
            }

            DetailItem {
                //% "Modified on HIBP"
                label: qsTrId("intfuorit-modified-on-hibp-label")
                value: breach.modifiedDate.toLocaleString(Qt.locale(), Locale.ShortFormat)
            }

            SectionHeader {
                //% "Description"
                text: qsTrId("intfuorit-description-label")
            }

            Text {
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                textFormat: Text.StyledText
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: breach.description
                linkColor: Theme.highlightColor
                onLinkActivated: Qt.openUrlExternally(link)
            }

            SectionHeader {
                //% "Compromised data"
                text: qsTrId("intfuorit-compromised-data-label")
            }

            Text {
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                textFormat: Text.StyledText
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: breach.dataClassesTranslated.join(", ")
            }

            Item {
                width: parent.width
                height: Theme.paddingLarge
            }

            Item {
                width: parent.width
                height: Theme.itemSizeExtraSmall
                Text {
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
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
