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

#define KEY_LANGUAGE "display/language"
#define KEY_CACHE_PERIOD "behavior/cacheperiod"
#define KEY_FIRST_START "system/firststart"

Configuration::Configuration(QObject *parent) : QSettings(parent)
{
    m_language = value(QStringLiteral(KEY_LANGUAGE)).toString();
    m_cachePeriod = value(QStringLiteral(KEY_CACHE_PERIOD), 3600*48).value<quint32>();
    m_firstStart = value(QStringLiteral(KEY_FIRST_START), true).toBool();
}


Configuration::~Configuration()
{

}


QString Configuration::language() const { return m_language; }

void Configuration::setLanguage(const QString &nLanguage)
{
    if (nLanguage != m_language) {
        m_language = nLanguage;
        qDebug("Language changed to \"%s\".", qUtf8Printable(m_language));
        setValue(QStringLiteral(KEY_LANGUAGE), m_language);
        emit languageChanged(m_language);
    }
}


quint32 Configuration::cachePeriod() const { return m_cachePeriod; }

void Configuration::setCachePeriod(quint32 nCachePeriod)
{
    if (nCachePeriod != m_cachePeriod) {
        m_cachePeriod = nCachePeriod;
        qDebug("Cache period changed to %u.", m_cachePeriod);
        setValue(QStringLiteral(KEY_CACHE_PERIOD), m_cachePeriod);
        emit cachePeriodChanged(m_cachePeriod);
    }
}


bool Configuration::firstStart() const { return m_firstStart; }

void Configuration::setFirstStart(bool nFirstStart)
{
    if (nFirstStart != m_firstStart) {
        m_firstStart = nFirstStart;
        qDebug("First start changed to %s.", m_firstStart ? "true" : "false");
        setValue(QStringLiteral(KEY_FIRST_START), m_firstStart);
        emit firstStartChanged(m_firstStart);
    }
}
