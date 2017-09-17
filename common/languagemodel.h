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

#ifndef LANGUAGEMODEL_H
#define LANGUAGEMODEL_H

#include <QAbstractListModel>
#include <QStringList>
#include <vector>

class LanguageModel : public QAbstractListModel
{
    Q_OBJECT
    Q_DISABLE_COPY(LanguageModel)
public:
    explicit LanguageModel(QObject *parent = nullptr);

    ~LanguageModel();

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QModelIndex index(int row, int column = 0, const QModelIndex &parent = QModelIndex()) const override;
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::UserRole) const override;

    Q_INVOKABLE int findIndex(const QString &langCode) const;

    static void setSupportedLangs(const QStringList &supportedLangs);

private:
    enum Roles {
        Code = Qt::UserRole + 1,
        Name
    };

    static QStringList m_supportedLangs;

    void init();

    std::vector<std::pair<QString,QString>> m_langs;
};

#endif // LANGUAGEMODEL_H
