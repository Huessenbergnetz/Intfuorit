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

QStringList LanguageModel::m_supportedLangs = QStringList();

LanguageModel::LanguageModel(QObject *parent) : QAbstractListModel(parent)
{
    init();
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


bool langLessThan(const std::pair<QString,QString> &a, const std::pair<QString,QString> &b)
{
    return (QString::localeAwareCompare(a.second, b.second) < 0);
}


void LanguageModel::init()
{
    m_langs.clear();

    std::pair<QString,QString> defLang;
    defLang.first = QStringLiteral("");
    //% "Default"
    defLang.second = qtTrId("intfuorit-default-lang");

    m_langs.reserve(m_supportedLangs.size() + 1);

    beginInsertRows(QModelIndex(), 0, LanguageModel::m_supportedLangs.size());

    if (!LanguageModel::m_supportedLangs.empty()) {

        const QStringList _supList = m_supportedLangs;
        for (const QString &supLang : _supList) {
            QLocale locale(supLang);
            std::pair<QString,QString> l;
            l.first = supLang;
            l.second = locale.nativeLanguageName() % QLatin1String(" (") % QLocale::languageToString(locale.language()) % QLatin1Char(')');
            m_langs.push_back(l);
        }

        std::sort(m_langs.begin(), m_langs.end(), langLessThan);

        m_langs.insert(m_langs.begin(), defLang);

    } else {

        m_langs.push_back(defLang);
    }

    endInsertRows();

    qDebug("Initialized language model with %u languages.", m_langs.size());
}


int LanguageModel::findIndex(const QString &langCode) const
{
    int idx = -1;

    if (!m_langs.empty()) {
        for (size_t i = 0; i < m_langs.size(); ++i) {
            if (m_langs.at(i).first == langCode) {
                idx = static_cast<int>(i);
                qDebug("Found index for language \"%s\" at %i in model with %u items.", qUtf8Printable(langCode), idx, m_langs.size());
                break;
            }
        }
    }

#ifdef QT_DEBUG
    if (idx < 0) {
        qDebug("Did not find index for language \"%s\" in model with %u items.", qUtf8Printable(langCode), m_langs.size());
    }
#endif

    return idx;
}
