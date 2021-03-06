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
import de.huessenbergnetz.hbnsc 1.0
import harbour.intfuorit 1.0
import "../models"

AboutPage {
    pageTitle: qsTrId("intfuorit-about")
    appTitle: "Intfuorit"
    //: Description on the About page
    //% "Unofficial haveibeenpwned.com client"
    appDescription: qsTrId("intfuorit-app-description")
    appHomepage: "https://github.com/Huessenbergnetz/Intfuorit"
    appCopyrightYearFrom: "2017"
    appCopyrightYearTo: "2018"
    appCopyrightHolder: "Matthias Fehring"
    appLicense: "GNU General Public License, Version 3"
    appLicenseFile: "GPLv3.qml"

    bugTrackerBaseUrl: "https://github.com/Huessenbergnetz/Intfuorit/issues/"

    contactCompany: "Hüssenbergnetz"
    contactName: "Matthias Fehring"
    contactStreet: "Zum Südholz"
    contactHouseNo: "8"
    contactZIP: "34439"
    contactCity: "Willebadessen-Eissen"
    //% "Germany"
    contactCountry: qsTrId("intfuorit-germany")
    contactEmail: Qt.atob("a29udGFrdEBodWVzc2VuYmVyZ25ldHouZGU=")
    contactWebsite: "www.huessenbergnetz.de"
    contactWebsiteLink: "https://www.huessenbergnetz.de"

    bugUrl: "https://github.com/Huessenbergnetz/Intfuorit/issues"
    translateUrl: "https://www.transifex.com/huessenbergnetz/intfuorit/"

    licensesModel: LicensesModel {}
    changelogModel: ChangelogModel {}
    contributorsModel: ContributorsModel {}
    contributorsAvatarBasePath: "/usr/share/harbour-intfuorit/images/contributors"

    privacyPolicyQmlFile: Qt.resolvedUrl("PrivacyPolicy.qml")
}
