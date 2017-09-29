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

ListModel {
    id: licensesModel

    ListElement {
        name: "libfuoten"
        author: "Matthias Fehring"
        version: "1.0.0"
        license: "GNU Lesser General Public License, Version 3"
        licenseFile: "LGPLv3.qml"
        website: "https://github.com/Huessenbergnetz/libintfuorit"
        description: ""
    }

    ListElement {
        name: "BT SFOS Components"
        author: "Matthias Fehring"
        version: "1.1.0"
        license: "Modified BSD License"
        licenseFile: "BSD-3.qml"
        website: "https://github.com/Buschtrommel/BT_SFOS_Components"
        description: ""
    }

    ListElement {
        name: "Have I Been Pwned Data"
        author: "Troy Hunt"
        license: "Creative Commons Attribution 4.0 International Public License"
        licenseFile: "CC-BY-4_0.qml"
        website: "https://haveibeenpwned.com"
    }

    ListElement {
        name: "Intfuorit Translations"
        author: "Intfuorit Translators"
        license: "Creative Commons Attribution 4.0 International Public License"
        licenseFile: "CC-BY-4_0.qml"
        website: "https://www.transifex.com/buschtrommel/intfuorit"
    }

    Component.onCompleted: {
        //% "Libintfuorit is a Qt based library that provides access to the haveibeenpwned.com API."
        licensesModel.get(0).description = qsTrId("intfuorit-libintfuorit-desc")
        //% "BT SFOS Components are a set of QML components for Sailfish OS."
        licensesModel.get(1).description = qsTrId("intfuorit-btsfoscmops-desc")
    }
}

