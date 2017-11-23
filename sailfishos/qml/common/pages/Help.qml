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
import "../models"

Page {
    id: help

    SilicaFlickable {
        id: helpFlick

        anchors.fill: parent
        contentHeight: helpCol.height

        VerticalScrollDecorator {
            flickable: helpFlick
            page: help
        }

        Column {
            id: helpCol
            width: parent.width
            spacing: Theme.paddingMedium

            PageHeader {
                page: help
                //% "Help/FAQ"
                title: qsTrId("intfuorit-help-faq")
            }

            Repeater {
                model: HelpModel {}

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

            Text {
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeMedium
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
                //% "Meaning of the icons"
                text: qsTrId("intfuorit-icon-meanings")
            }

            Item {
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                height: iconsCol.height

                Column {
                    id: iconsCol
                    width: parent.width
                    spacing: 0

                    Row {
                        width: parent.width
                        spacing: Theme.paddingMedium

                        Image {
                            source: "image://intfuorit/icon-s-sensitive-breach"
                        }

                        Text {
                            color: Theme.primaryColor
                            font.pixelSize: Theme.fontSizeSmall
                            textFormat: Text.PlainText
                            wrapMode: Text.WordWrap
                            text: qsTrId("intfuorit-sensitive-breach-hint")
                        }
                    }

                    Row {
                        width: parent.width
                        spacing: Theme.paddingMedium

                        Image {
                            source: "image://intfuorit/icon-s-retired-breach"
                        }

                        Text {
                            color: Theme.primaryColor
                            font.pixelSize: Theme.fontSizeSmall
                            textFormat: Text.PlainText
                            wrapMode: Text.WordWrap
                            text: qsTrId("intfuorit-retired-breach-hint")
                        }
                    }

                    Row {
                        width: parent.width
                        spacing: Theme.paddingMedium

                        Image {
                            source: "image://intfuorit/icon-s-unverified-breach"
                        }

                        Text {
                            color: Theme.primaryColor
                            font.pixelSize: Theme.fontSizeSmall
                            textFormat: Text.PlainText
                            wrapMode: Text.WordWrap
                            text: qsTrId("intfuorit-unverified-breach-hint")
                        }
                    }

                    Row {
                        width: parent.width
                        spacing: Theme.paddingMedium

                        Image {
                            source: "image://intfuorit/icon-s-fabricated-breach"
                        }

                        Text {
                            color: Theme.primaryColor
                            font.pixelSize: Theme.fontSizeSmall
                            textFormat: Text.PlainText
                            wrapMode: Text.WordWrap
                            text: qsTrId("intfuorit-fabricated-breach-hint")
                        }
                    }

                    Row {
                        width: parent.width
                        spacing: Theme.paddingMedium

                        Image {
                            source: "image://intfuorit/icon-s-spam-list"
                        }

                        Text {
                            color: Theme.primaryColor
                            font.pixelSize: Theme.fontSizeSmall
                            textFormat: Text.PlainText
                            wrapMode: Text.WordWrap
                            text: qsTrId("intfuorit-spam-list-hint")
                        }
                    }
                }
            }

            Item {
                width: parent.width
                height: Theme.paddingLarge
            }
        }
    }
}
