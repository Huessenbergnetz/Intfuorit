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
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0
import de.huessenbergnetz.hbnsc 1.0
import harbour.intfuorit 1.0

Page {
    id: settingsPage

    allowedOrientations: Orientation.All

    SilicaFlickable {
        id: settingsFlick
        anchors.fill: parent

        contentHeight: settingsGrid.height

        VerticalScrollDecorator { flickable: settingsFlick; page: settingsPage }

        GridLayout {
            id: settingsGrid
            anchors { left: parent.left; right: parent.right; }

            columnSpacing: 0
            rowSpacing: Theme.paddingSmall

            columns: Screen.sizeCategory < Screen.Large ? (settingsPage.isLandscape ? 2 : 1) : (settingsPage.isLandscape ? 4 : 2)

            PageHeader {
                title: qsTrId("intfuorit-settings")
                page: settingsPage
                Layout.columnSpan: settingsGrid.columns
                Layout.fillWidth: true
            }

            SectionHeader {
                //: Section header on the settings page
                //% "Display"
                text: qsTrId("intfuorit-settings-display")
                Layout.columnSpan: settingsGrid.columns
                Layout.preferredWidth: settingsGrid.width - Theme.horizontalPageMargin
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: langPicker.height
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                LanguagePicker {
                    id: langPicker
                    model: LanguageModel { id: langModel }
                    onCurrentIndexChanged: if (currentItem) { config.language = currentItem.value }
                    currentIndex: langModel.findIndex(config.language)
                }
            }

            SectionHeader {
                //: Section header on the settings page
                //% "Behavior"
                text: qsTrId("intfuorit-settings-behavior")
                Layout.columnSpan: settingsGrid.columns
                Layout.preferredWidth: settingsGrid.width - Theme.horizontalPageMargin
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: langChoser.height
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                ComboBox {
                    id: cachePeriodChoser
                    //: Label for a combobox (drop down menu)
                    //% "Cache period"
                    label: qsTrId("intfuorit-cache-period-choser-label")
                    //: Description for a combobox (drop down menu)
                    //% "The cache period is used to store API results for the specified duration before sending a new request to the API."
                    description: qsTrId("intfuorit-cache-period-choser-desc")
                    menu: ContextMenu {
                        Repeater {
                            model: CachePeriodModel { id: cachePeriodModel }
                            MenuItem { text: model.name; readonly property int value: model.period }
                        }
                    }
                    onCurrentIndexChanged: if (currentItem) { config.cachePeriod = currentItem.value }
                    currentIndex: cachePeriodModel.findIndex(config.cachePeriod)
                }
            }
        }
    }
}
