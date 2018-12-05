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

#include "languagemodel.h"
#include <QLocale>
#include <QStringBuilder>
#include <algorithm>

QStringList LanguageModel::m_supportedLangs = QStringList();

bool langLessThan(const std::pair<QString,QString> &a, const std::pair<QString,QString> &b)
{
    return (QString::localeAwareCompare(a.second, b.second) < 0);
}

LanguageModel::LanguageModel(QObject *parent) : QAbstractListModel(parent)
{
    m_langs.reserve(m_supportedLangs.size() + 1);

    beginInsertRows(QModelIndex(), 0, LanguageModel::m_supportedLangs.size());

    if (!LanguageModel::m_supportedLangs.empty()) {

        const QStringList _supList = m_supportedLangs;
        for (const QString &supLang : _supList) {
            QLocale locale(supLang);
            const QString langName = locale.nativeLanguageName() % QLatin1String(" (") % QLocale::languageToString(locale.language()) % QLatin1Char(')');
            m_langs.push_back(std::make_pair(supLang, langName));
        }

        std::sort(m_langs.begin(), m_langs.end(), langLessThan);

        //% "Default"
        m_langs.insert(m_langs.begin(), std::make_pair(QString(), qtTrId("intfuorit-default-lang")));

    } else {

        m_langs.push_back(std::make_pair(QString(), qtTrId("intfuorit-default-lang")));
    }

    endInsertRows();

    qDebug("Initialized language model with %zu languages.", m_langs.size());
}


LanguageModel::~LanguageModel()
{

}


int LanguageModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_langs.size();
}


QModelIndex LanguageModel::index(int row, int column, const QModelIndex &parent) const
{
    QModelIndex idx;

    if (hasIndex(row, column, parent)) {
        idx = createIndex(row, column);
    }

    return idx;
}


QHash<int, QByteArray> LanguageModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractItemModel::roleNames();
    roles.insert(Code, QByteArrayLiteral("code"));
    roles.insert(Name, QByteArrayLiteral("name"));
    return roles;
}


QVariant LanguageModel::data(const QModelIndex &index, int role) const
{
    QVariant var;

    if (!index.isValid() || (static_cast<size_t>(index.row()) > (m_langs.size() - 1))) {
        return var;
    }

    const std::pair<QString,QString> l = m_langs.at(index.row());

    switch (role) {
    case Code:  var.setValue(l.first);   break;
    case Name:  var.setValue(l.second);   break;
    default:
        break;
    }

    return var;
}


void LanguageModel::setSupportedLangs(const QStringList &supportedLangs)
{
    m_supportedLangs = supportedLangs;
}


int LanguageModel::findIndex(const QString &langCode) const
{
    int idx = -1;

    if (!m_langs.empty()) {
        for (std::size_t i = 0; i < m_langs.size(); ++i) {
            if (m_langs.at(i).first == langCode) {
                idx = static_cast<int>(i);
                qDebug("Found index for language \"%s\" at %i in model with %zu languages.", qUtf8Printable(langCode), idx, m_langs.size());
                break;
            }
        }
    }

#ifdef QT_DEBUG
    if (idx < 0) {
        qDebug("Did not find index for language \"%s\" in model with %zu languages.", qUtf8Printable(langCode), m_langs.size());
    }
#endif

    return idx;
}

#include "moc_languagemodel.cpp"
