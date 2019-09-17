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

#include "licensesmodel.h"
#include <Intfuorit/intfuorit.h>

LicensesModel::LicensesModel(QObject *parent) : Hbnsc::LicenseModel(parent)
{
    add(QStringLiteral("Libintfuorit"),
        QStringLiteral("Matthias Fehring"),
        Intfuorit::version().toString(),
        QUrl(QStringLiteral("https://github.com/Huessenbergnetz/libintfuorit")),
        //: description for libintfuorit in the list of used 3rd party components
        //% "Libintfuorit is a Qt based library that provides access to the haveibeenpwned.com API."
        qtTrId("intfuorit-libintfuorit-desc"),
        QStringLiteral("GNU Lesser General Public License, Version 3"),
        QStringLiteral("LGPLv3.qml"),
        QUrl(QStringLiteral("https://github.com/Huessenbergnetz/libintfuorit/blob/master/LICENSE")),
        QUrl());

    add(QStringLiteral("Libintfuorit Translations"),
        QStringLiteral("Libintfuorit Translators"),
        QString(),
        QUrl(QStringLiteral("https://www.transifex.com/huessenbergnetz/libintfuorit")),
        //: description for libintfuorit translations in the list of used 3rd party components
        //% "Libintfuorit is a Qt based library that provides access to the haveibeenpwned.com API. Translations are provided by the community. "
        qtTrId("intfuorit-libintfuorit-trans-desc"),
        QStringLiteral("Creative Commons Attribution 4.0 International Public License"),
        QStringLiteral("CC-BY-4_0.qml"),
        QUrl(QStringLiteral("https://github.com/Huessenbergnetz/libintfuorit/blob/master/LICENSE.translations")),
        QUrl());

    add(QStringLiteral("Have I Been Pwned Data & API"),
        QStringLiteral("Troy Hunt"),
        QString(),
        QUrl(QStringLiteral("https://haveibeenpwned.com")),
        //: description for HIBP in the list of used 3rd party components
        //% "“Have I been Pwned?” is a web service created by Troy Hunt that allows internet users to check if their personal data has been compromised by data breaches."
        qtTrId("intfuorit-hibp-desc"),
        QStringLiteral("Creative Commons Attribution 4.0 International Public License"),
        QStringLiteral("CC-BY-4_0.qml"),
        QUrl(QStringLiteral("https://haveibeenpwned.com/API/v2#License")),
        QUrl());

    add(QStringLiteral("Intfuorit Translations"),
        QStringLiteral("Intfuorit Translators"),
        QString(),
        QUrl(QStringLiteral("https://www.transifex.com/huessenbergnetz/intfuorit")),
        //: description for Intfuorit Translations in the list of used 3rd party components
        //% "The translations for Intfuorit are provided by the community. To see who is responsible for which translation, open the contributors page."
        qtTrId("intfuorit-trans-desc"),
        QStringLiteral("Creative Commons Attribution 4.0 International Public License"),
        QStringLiteral("CC-BY-4_0.qml"),
        QUrl(QStringLiteral("https://github.com/Huessenbergnetz/Intfuorit/blob/master/LICENSE.translations")),
        QUrl());

    add(QStringLiteral("Font Awesome Free Icons"),
        QStringLiteral("Font Awesome Team"),
        QString(),
        QUrl(QStringLiteral("http://fontawesome.com/")),
        //: description for Font Awesome in the list of used 3rd party components
        //% "Font Awesome is a font and icon toolkit initially created by Dave Gandy."
        qtTrId("intfuorit-font-awesome-desc"),
        QStringLiteral("Creative Commons Attribution 4.0 International Public License"),
        QStringLiteral("CC-BY-4_0.qml"),
        QUrl(QStringLiteral("https://fontawesome.com/license/free")),
        QUrl());

    add(QStringLiteral("ADVobfuscator"),
        QStringLiteral("Sebastien Andrivet"),
        QString(),
        QUrl(QStringLiteral("https://github.com/andrivet/ADVobfuscator")),
        //: description for ADVobfuscator in the list of used 3rd party components
        //% "ADVobfuscator is an obfuscation library based on C++11/14 and metaprogramming. It is used by Intfuorit to obfuscate the internal used AES key to encrypt stored API keys."
        qtTrId("fuoten-advobfuscator-desc"),
        QStringLiteral("Modified BSD License"),
        QStringLiteral("BSD-3.qml"),
        QUrl(),
        QUrl());

    sortLicenses();
}

LicensesModel::~LicensesModel()
{

}
