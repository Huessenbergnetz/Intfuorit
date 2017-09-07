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

#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <QtQml>
#include <QGuiApplication>
#include <QQuickView>
#include <QLocale>
#include <QTranslator>
#include <QDir>
#include <QStandardPaths>

#ifndef CLAZY
#include <sailfishapp.h>
#endif

#include <Intfuorit/Error>

#include "../../common/configuration.h"

int main(int argc, char *argv[])
{
#ifndef CLAZY
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
#else
    QScopedPointer<QGuiApplication> app(new QGuiApplication(argc, argv));
#endif

    app->setApplicationName(QStringLiteral("harbour-intfuorit"));
    app->setApplicationDisplayName(QStringLiteral("Intfuorit"));
    app->setApplicationVersion(QStringLiteral(VERSION_STRING));

    auto dataDir = new QDir(QStandardPaths::writableLocation(QStandardPaths::DataLocation));
    auto cacheDir = new QDir(QStandardPaths::writableLocation(QStandardPaths::CacheLocation));

    if (Q_UNLIKELY(!dataDir->exists())) {
        if (!dataDir->mkpath(dataDir->absolutePath())) {
            delete dataDir;
            delete cacheDir;
            qFatal("Failed to create data directory.");
        }
    }

    if (Q_UNLIKELY(!cacheDir->exists())) {
        if (!cacheDir->mkpath(cacheDir->absolutePath())) {
            delete dataDir;
            delete cacheDir;
            qFatal("Failed to create cache directory.");
        }
    }

    delete dataDir;
    delete cacheDir;

    QScopedPointer<Configuration> config(new Configuration);

    if (!config->language().isEmpty()) {
        QLocale::setDefault(QLocale(config->language()));
    } else {
        QLocale::setDefault(QLocale::system());
    }

#ifndef CLAZY
    const QString l10nDir = SailfishApp::pathTo(QStringLiteral("l10n")).toString(QUrl::RemoveScheme);

    QTranslator *appTrans = new QTranslator(app.data());
    if (Q_LIKELY(appTrans->load(QLocale(), QStringLiteral("intfuorit"), QStringLiteral("_"), l10nDir, QStringLiteral(".qm")))) {
        app->installTranslator(appTrans);
    }

    QTranslator *libTrans = new QTranslator(app.data());
    if (Q_LIKELY(libTrans->load(QLocale(), QStringLiteral("libintfuorit"), QStringLiteral("_"), l10nDir, QStringLiteral(".qm")))) {
        app->installTranslator(libTrans);
    }
#endif

    qmlRegisterType<Intfuorit::Error>("harbour.intfuorit", 1, 0, "IntfuoritError");

#ifndef CLAZY
    QScopedPointer<QQuickView> view(SailfishApp::createView());
#else
    QScopedPointer<QQuickView> view(new QQuickView);
#endif

#ifndef CALZY
    view->setSource(SailfishApp::pathTo(QStringLiteral("qml/harbour-intfuorit.qml")));
#endif

    view->show();

    return app->exec();
}
