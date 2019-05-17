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

ListModel {
    id: contModel
    ListElement {
        name: "Matthias Fehring (Buschmann)"
        role: ""
        section: ""
        image: "buschmann.png"
        website: "https://www.buschmann23.de"
        twitter: "buschmann23"
        github: "buschmann23"
    }

    ListElement {
        name: "Åke Engelbrektson"
        role: ""
        section: ""
        website: "https://svenskasprakfiler.se"
    }

    Component.onCompleted: {
        //% "Main developer, Intfuorit creator"
        contModel.get(0).role = qsTrId("intfuorit-author-role")
        //% "Author"
        contModel.get(0).section = qsTrId("Intfuorit-author-section")

        //% "Swedish translation"
        contModel.get(1).role = qsTrId("intfuorit-swedish-translation")
        //% "Thanks to"
        contModel.get(1).section = qsTrId("intfuorit-thanks-to")
    }
}

