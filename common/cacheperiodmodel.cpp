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
    init();
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

    if (!index.isValid() || (static_cast<size_t>(index.row()) > (m_periods.size() - 1))) {
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

void CachePeriodModel::clear()
{
    if (!m_periods.empty()) {
        beginRemoveRows(QModelIndex(), 0, m_periods.size() - 1);
        m_periods.clear(),
        endRemoveRows();
    }
}

void CachePeriodModel::init()
{
    clear();

    m_periods.reserve(5);

    beginInsertRows(QModelIndex(), 0, 4);

    std::pair<quint32,QString> per0;
    per0.first = 0;
    //% "Disabled"
    per0.second = qtTrId("intfuorit-cache-period-disabled");
    m_periods.push_back(per0);

    std::pair<quint32,QString> per1;
    per1.first = 43200;
    //% "12 hours"
    per1.second = qtTrId("intfuorit-cache-period-half-day");
    m_periods.push_back(per1);

    std::pair<quint32,QString> per2;
    per2.first = 86400;
    //% "1 day"
    per2.second = qtTrId("intfuorit-cache-period-one-day");
    m_periods.push_back(per2);

    std::pair<quint32,QString> per3;
    per3.first = 172800;
    //% "2 days"
    per3.second = qtTrId("intfuorit-cache-period-two-days");
    m_periods.push_back(per3);

    std::pair<quint32,QString> per4;
    per4.first = 604800;
    //% "1 week"
    per4.second = qtTrId("intfuorit-cache-period-one-week");
    m_periods.push_back(per4);

    endInsertRows();

    qDebug("Initialized cache period model with %u periods.", m_periods.size());
}


int CachePeriodModel::findIndex(quint32 period) const
{
    int idx = -1;

    if (!m_periods.empty()) {
        for (size_t i = 0; i < m_periods.size(); ++i) {
            if (m_periods.at(i).first == period) {
                idx = static_cast<int>(i);
                qDebug("Found index for period %u at %i in model with %u items.", period, idx, m_periods.size());
                break;
            }
        }
    }

#ifdef QT_DEBUG
    if (idx < 0) {
        qDebug("Did not find index for period %u in model with %u items.", period, m_periods.size());
    }
#endif


    return idx;
}
