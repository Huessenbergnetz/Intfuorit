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
import "../models"

Page {
    id: privacyPolicy

    SilicaFlickable {
        id: privacyPolicyFlick

        anchors.fill: parent
        contentHeight: privacyPolicyCol.height

        VerticalScrollDecorator {
            flickable: privacyPolicyFlick
            page: privacyPolicy
        }

        Column {
            id: privacyPolicyCol
            width: parent.width
            spacing: Theme.paddingMedium

            PageHeader {
                page: privacyPolicy
                //% "Privacy policy"
                title: qsTrId("intfuorit-privacy-policy")
            }

            Repeater {
                model: PrivacyPolicyModel {}

                delegate: Text {
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                    color: model.header ? Theme.highlightColor : Theme.primaryColor
                    font.pixelSize: model.header ? Theme.fontSizeMedium : Theme.fontSizeSmall
                    textFormat: model.format ? model.format : Text.PlainText
                    onLinkActivated: Qt.openUrlExternally(link)
                    text: model.text
                    wrapMode: Text.WordWrap
                    linkColor: Theme.highlightColor
                }
            }

            Item {
                width: parent.width
                height: Theme.paddingLarge
            }
        }
    }
}
