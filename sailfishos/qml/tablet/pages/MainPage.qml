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

Page {
    id: mainPage

    allowedOrientations: Orientation.All

    SilicaGridView {
        id: breachesListView
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                //% "About"
                text: qsTrId("intfuorit-about")
            }
            MenuItem {
                //% "Settings"
                text: qsTrId("intfuorit-settings")
            }
            MenuItem {
                //% "Reload"
                text: qsTrId("intfuorit-reload")
            }
        }

        VerticalScrollDecorator {
            flickable: breachesListView
            page: mainPage
        }

        header: PageHeader {
            title: "Intfuorit"
            description: error.text
            page: mainPage
        }
    }
}

