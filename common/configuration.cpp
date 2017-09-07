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

#include "configuration.h"

Configuration::Configuration(QObject *parent) : QSettings(parent)
{
    m_language = value(QStringLiteral("display/language")).toString();
}


Configuration::~Configuration()
{

}


QString Configuration::language() const { return m_language; }

void Configuration::setLanguage(const QString &nLanguage)
{
    if (nLanguage != m_language) {
        m_language = nLanguage;
        qDebug("Lanugage changed to \"%s\".", qUtf8Printable(nLanguage));
        emit languageChanged(nLanguage);
    }
}
