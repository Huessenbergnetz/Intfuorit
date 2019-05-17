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

#ifndef CACHEPERIODMODL_H
#define CACHEPERIODMODL_H

#include <QAbstractListModel>
#include <vector>
#include <utility>

class CachePeriodModel : public QAbstractListModel
{
    Q_OBJECT
    Q_DISABLE_COPY(CachePeriodModel)
public:
    explicit CachePeriodModel(QObject *parent = nullptr);

    ~CachePeriodModel() override;

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QModelIndex index(int row, int column = 0, const QModelIndex &parent = QModelIndex()) const override;
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::UserRole) const override;

    Q_INVOKABLE int findIndex(quint32 period) const;

private:
    enum Roles {
        Period = Qt::UserRole + 1,
        Name
    };

    std::vector<std::pair<quint32,QString>> m_periods;
};

#endif // CACHEPERIODMODL_H
