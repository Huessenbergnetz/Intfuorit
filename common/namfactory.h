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

#ifndef INTFUORITNAMFACTORY_H
#define INTFUORITNAMFACTORY_H

#include "QQmlNetworkAccessManagerFactory"

class QNetworkAccessManager;
class QNetworkDiskCache;

class NamFactory : public QQmlNetworkAccessManagerFactory
{
public:
    NamFactory(QNetworkDiskCache *dk);

    QNetworkAccessManager* create(QObject *parent) override;

private:
    QNetworkDiskCache *m_dk = nullptr;
};

#endif // INTFUORITNAMFACTORY_H
