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

#include "cacheperiodmodel.h"

CachePeriodModel::CachePeriodModel(QObject *parent) : QAbstractListModel(parent)
{
    m_periods.reserve(5);

    beginInsertRows(QModelIndex(), 0, 4);

    //% "Disabled"
    m_periods.push_back(std::make_pair(static_cast<quint32>(0), qtTrId("intfuorit-cache-period-disabled")));

    //% "12 hours"
    m_periods.push_back(std::make_pair(static_cast<quint32>(43200), qtTrId("intfuorit-cache-period-half-day")));

    //% "1 day"
    m_periods.push_back(std::make_pair(static_cast<quint32>(86400), qtTrId("intfuorit-cache-period-one-day")));

    //% "2 days"
    m_periods.push_back(std::make_pair(static_cast<quint32>(172800), qtTrId("intfuorit-cache-period-two-days")));

    //% "1 week"
    m_periods.push_back(std::make_pair(static_cast<quint32>(604800), qtTrId("intfuorit-cache-period-one-week")));

    endInsertRows();

    qDebug("Initialized cache period model with %zu periods.", m_periods.size());
}


CachePeriodModel::~CachePeriodModel()
{

}


int CachePeriodModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_periods.size();
}


QModelIndex CachePeriodModel::index(int row, int column, const QModelIndex &parent) const
{
    QModelIndex idx;

    if (hasIndex(row, column, parent)) {
        idx = createIndex(row, column);
    }

    return idx;
}


QHash<int, QByteArray> CachePeriodModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractItemModel::roleNames();
    roles.insert(Period, QByteArrayLiteral("period"));
    roles.insert(Name, QByteArrayLiteral("name"));
    return roles;
}


QVariant CachePeriodModel::data(const QModelIndex &index, int role) const
{
    QVariant var;

    if (!index.isValid() || (static_cast<std::size_t>(index.row()) > (m_periods.size() - 1))) {
        return var;
    }

    const std::pair<quint32,QString> l = m_periods.at(index.row());

    switch (role) {
    case Period:    var.setValue(l.first);  break;
    case Name:      var.setValue(l.second); break;
    default:
        break;
    }

    return var;
}


int CachePeriodModel::findIndex(quint32 period) const
{
    int idx = -1;

    if (!m_periods.empty()) {
        for (std::size_t i = 0; i < m_periods.size(); ++i) {
            if (m_periods.at(i).first == period) {
                idx = static_cast<int>(i);
                qDebug("Found index for period %u at %i in model with %zu periods.", period, idx, m_periods.size());
                break;
            }
        }
    }

#ifdef QT_DEBUG
    if (idx < 0) {
        qDebug("Did not find index for period %u in model with %zu periods.", period, m_periods.size());
    }
#endif


    return idx;
}

#include "moc_cacheperiodmodel.cpp"
