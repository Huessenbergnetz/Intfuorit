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

ListItem {
    id: breachesListItem
    contentHeight: Theme.itemSizeMedium

    property string searchTerm
    property real countWidth

    onClicked: pageStack.push(Qt.resolvedUrl("BreachPage.qml"), {breach: model.item})

    Row {
        id: breachesListItemRow
        anchors { left: parent.left; leftMargin: Theme.horizontalPageMargin; right: parent.right; rightMargin: Theme.horizontalPageMargin; verticalCenter: parent.verticalCenter }
        spacing: Theme.paddingSmall
        Image {
            id: logo
            height: textCol.height
            width: height * 1.5
            source: "https://haveibeenpwned.com/Content/Images/PwnedLogos/" + model.name + "." + model.logoType
            fillMode: Image.PreserveAspectFit
        }

        Column {
            id: textCol
            width: parent.width - logo.width - Theme.paddingSmall
            Row {
                width: parent.width
                spacing: Theme.paddingSmall
                Label {
                    width: countWidth
                    text: model.pwnCount.toLocaleString(Qt.locale(), 'f', 0)
                    horizontalAlignment: Qt.AlignRight
                    font.pixelSize: Theme.fontSizeSmall
                    color: breachesListItem.highlighted ? Theme.highlightColor : Theme.primaryColor
                    textFormat: Text.PlainText
                }

                Label {
                    width: parent.width - countWidth - Theme.paddingSmall
                    //% "%1 account(s)"
                    text: qsTrId("intfuorit-title-counts-label", model.pwnCount ? model.pwnCount : 0).arg(Theme.highlightText(model.title, searchTerm, Theme.highlightColor))
                    truncationMode: TruncationMode.Fade
                    horizontalAlignment: Qt.AlignLeft
                    textFormat: Text.StyledText
                    font.pixelSize: Theme.fontSizeSmall
                    color: breachesListItem.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
            }

            Row {
                width: parent.width
                spacing: Theme.paddingSmall

                Text {
                    width: countWidth
                    textFormat: Text.PlainText
                    horizontalAlignment: Qt.AlignRight
                    font.pixelSize: Theme.fontSizeExtraSmall
                    text: model.breachDate.toLocaleDateString(Qt.locale(), Locale.ShortFormat)
                    color: breachesListItem.highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                }

                Label {
                    horizontalAlignment: Qt.AlignLeft
                    font.pixelSize: Theme.fontSizeExtraSmall
                    text: Theme.highlightText(model.domain, searchTerm, Theme.secondaryHighlightColor)
                    color: breachesListItem.highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                    truncationMode: TruncationMode.Fade
                    textFormat: Text.StyledText
                }
            }
        }
    }
}
