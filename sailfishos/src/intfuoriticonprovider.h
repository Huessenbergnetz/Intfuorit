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

#ifndef INTFUORITICONPROVIDER_H
#define INTFUORITICONPROVIDER_H

#include <sailfishapp.h>
#include <silicatheme.h>
#include <QQuickImageProvider>
#include <QPainter>
#include <QColor>
#include <QStringBuilder>

class IntfuoritIconProvider : public QQuickImageProvider
{
public:
    IntfuoritIconProvider() : QQuickImageProvider(QQuickImageProvider::Pixmap)
    {
        Silica::Theme theme;
        const qreal pixelRatio = theme.pixelRatio();
        qreal best;
        qreal lastDist = 100.0;
        for (const qreal &r : {1.0, 1.25, 1.5, 1.75, 2.0}) {
            qreal dist = pixelRatio - r;
            if (dist < 0.0) {
                dist *= -1.0;
            }
            if (dist < lastDist) {
                best = r;
                lastDist = dist;
            }
        }

        QString ratio = QString::number(best);
        if (!ratio.contains(QLatin1Char('.'))) {
            ratio.append(QLatin1String(".0"));
        }

        m_basePath = QStringLiteral("images/z") % ratio % QLatin1Char('/');
    }

    virtual QPixmap requestPixmap(const QString &id, QSize *size, const QSize& requestedSize) override
    {
        QPixmap out;

        QStringList parts = id.split(QLatin1Char('?'));

        QPixmap sourcePixmap(SailfishApp::pathTo(m_basePath % parts.at(0) % QStringLiteral(".png")).toString(QUrl::RemoveScheme));

        if (size) {
            *size = sourcePixmap.size();
        }

        if (parts.size() > 1) {
            if (QColor::isValidColor(parts.at(1))) {
                QPainter painter(&sourcePixmap);
                painter.setCompositionMode(QPainter::CompositionMode_SourceIn);
                painter.fillRect(sourcePixmap.rect(), parts.at(1));
                painter.end();
            }
        }

        if ((requestedSize.width() > 0) && (requestedSize.height() > 0)) {
            out = sourcePixmap.scaled(requestedSize.width(), requestedSize.height(), Qt::IgnoreAspectRatio);
        } else {
            out = sourcePixmap;
        }

        return out;
    }

private:
    QString m_basePath;
};

#endif // INTFUORITICONPROVIDER_H
