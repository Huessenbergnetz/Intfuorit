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

/*
  Types:
  0 - New
  1 - Improved/Enhanced
  2 - Fixed
  3 - Note
*/

ListModel {
    ListElement {
        version: "1.1.0"
        date: 1544458854000
        entries: [
            ListElement { type: 0; issue: "6"; description: "add password check" },
            ListElement { type: 0; issue: "5"; description: "add more sort options for the breaches list" },
            ListElement { type: 0; issue: "1"; description: "show indicators for breach classification" },
            ListElement { type: 0; issue: ""; description: "Swedish translation by Åke Engelbrektson" },
            ListElement { type: 1; issue: "7"; description: "unify selection of sort role and sort order" }
        ]
    }

    ListElement {
        version: "1.0.0"
        date: 1506692990000
        entries: [
            ListElement { type: 3; issue: ""; description: "first released version" }
        ]
    }
}

