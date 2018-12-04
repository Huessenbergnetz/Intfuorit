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
    id: ppmodel

    ListElement {
        header: true
        text: ""
    }

    ListElement {
        text: ""
    }

    ListElement {
        header: true
        text: ""
    }

    ListElement {
        format: Text.StyledText
        text: ""
    }

    ListElement {
        header: true
        text: ""
    }

    ListElement {
        format: Text.StyledText
        text: ""
    }

    ListElement {
        header: true
        text: ""
    }

    ListElement {
        text: ""
    }

    ListElement {
        header: true
        text: ""
    }

    ListElement {
        format: Text.StyledText
        text: ""
    }

    Component.onCompleted: {
        //% "What information does Intfuorit collect?"
        ppmodel.get(0).text = qsTrId("intfuorit-privacy-0")
        //% "Intfuorit does not require any data from you for the sole display of the breached sites and services. If you want to check one of your user accounts, Intfuorit sends the email addresses or usernames you have entered to the servers of haveibeenpwned.com. This information will not be shared with the author of Intfuorit or any third party other than haveibeenpwned.com. You provide your data voluntarily at any time."
        ppmodel.get(1).text = qsTrId("intfuorit-privacy-1")
        //% "What does Intfuorit use your information for?"
        ppmodel.get(2).text = qsTrId("intfuorit-privacy-2")
        //% "If you wish to have your e-mail address or user name checked, this data will be sent to the API of haveibeenpwned.com. Information about privacy at haveibeenpwned.com can be found <a href='%1'>here</a>."
        ppmodel.get(3).text = qsTrId("intfuorit-privacy-3").arg("https://haveibeenpwned.com/FAQs")
        //% "Does Intfuorit disclose any information to third parties?"
        ppmodel.get(4).text = qsTrId("intfuorit-privacy-4")
        //% "If you wish to have your e-mail address or user name checked, this data will be sent to the API of haveibeenpwned.com. Information about privacy at haveibeenpwned.com can be found <a href='%1'>here</a>."
        ppmodel.get(5).text = qsTrId("intfuorit-privacy-5").arg("https://haveibeenpwned.com/FAQs")
        //% "Your consent"
        ppmodel.get(6).text = qsTrId("intfuorit-privacy-8")
        //% "By using Intfuorit, you consent to this privacy policy."
        ppmodel.get(7).text = qsTrId("intfuorit-privacy-9")
        //% "Contact"
        ppmodel.get(8).text = qsTrId("intfuorit-privacy-10")
        ppmodel.get(9).text = String("Hüssenbergnetz<br>Matthias Fehring<br>Zum Südholz 8<br>34439 Willebadessen-Eissen<br>%1<br><a href='https://www.huessenbergnetz.de'>www.huessenbergnetz.de</a><br><a href='mailto:%2'>%2</a>").arg(qsTrId("intfuorit-germany")).arg(Qt.atob("a29udGFrdEBodWVzc2VuYmVyZ25ldHouZGU="))
    }
}

