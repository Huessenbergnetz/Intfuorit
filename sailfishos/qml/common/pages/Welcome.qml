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
import "../models"

Dialog {
    id: welcomeDialog

    backNavigation: false
    acceptDestination: Screen.sizeCategory >= Screen.Large
                       ? Qt.resolvedUrl("../../tablet/pages/MainPage.qml")
                       : Qt.resolvedUrl("../../phone/pages/MainPage.qml")
    acceptDestinationAction: PageStackAction.Replace

    SilicaFlickable {
        id: welcomeFlick
        anchors.fill: parent
        contentHeight: welcomeCol.height + welcomeHeader.height

        VerticalScrollDecorator { flickable: welcomeFlick; page: welcomeDialog }

        DialogHeader {
            id: welcomeHeader
            //% "Welcome to Intfuorit"
            title: qsTrId("intfuorit-welcome")
            dialog: welcomeDialog
            flickable: welcomeFlick
        }

        Column {
            id: welcomeCol
            anchors { left: parent.left; right: parent.right; top: welcomeHeader.bottom }
            spacing: Theme.paddingMedium

            Text {
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                //% "Intfuorit is a client for haveibeenpwned.com (HIBP), a service created by Troy Hunt, that allows you to check if one of your user accounts is part of a data breach. Intfuorit is the old high german word for kidnapped."
                text: qsTrId("intfuorit-welcome-description")
                wrapMode: Text.WordWrap
            }

            Text {
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                //% "By using Intfuorit, you consent to the following privacy policy."
                text: qsTrId("intfuorit-welcome-privacy-consent")
                wrapMode: Text.WordWrap
            }

            Item {
                width: parent.width
                height: Theme.paddingLarge
            }

            Label {
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
                truncationMode: TruncationMode.Fade
                text: qsTrId("intfuorit-privacy-policy")
            }

            Repeater {
                id: licenseRep
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

    onAccepted: config.firstStart = false
}
