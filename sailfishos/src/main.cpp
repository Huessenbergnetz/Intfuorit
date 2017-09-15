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

#include <QQmlContext>
#include <QGuiApplication>
#include <QQuickView>
#include <QLocale>
#include <QTranslator>
#include <QDir>
#include <QStandardPaths>
#include <QQmlEngine>
#include <QNetworkAccessManager>
#include <QNetworkDiskCache>

#ifndef CLAZY
#include <sailfishapp.h>
#endif

#include <Intfuorit/Error>
#include <Intfuorit/Objects/Breach>
#include <Intfuorit/Models/BreachesListModel>
#include <Intfuorit/Models/BreachesListFilterModel>
#include <Intfuorit/Objects/Paste>
#include <Intfuorit/Models/PastesListModel>

#include "../../common/configuration.h"
#include "../../common/namfactory.h"

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
    auto qmlCacheDir = new QDir(cacheDir->absolutePath() + QLatin1String("/qmlcache"));

    if (Q_UNLIKELY(!dataDir->exists())) {
        if (!dataDir->mkpath(dataDir->absolutePath())) {
            delete dataDir;
            delete cacheDir;
            delete qmlCacheDir;
            qFatal("Failed to create data directory.");
        }
    }

    if (Q_UNLIKELY(!cacheDir->exists())) {
        if (!cacheDir->mkpath(cacheDir->absolutePath())) {
            delete dataDir;
            delete cacheDir;
            delete qmlCacheDir;
            qFatal("Failed to create cache directory.");
        }
    }

    if (Q_UNLIKELY(!qmlCacheDir->exists())) {
        if (!qmlCacheDir->mkpath(qmlCacheDir->absolutePath())) {
            delete dataDir;
            delete cacheDir;
            delete qmlCacheDir;
            qFatal("Failed to create qml cache directory.");
        }
    }

    QScopedPointer<QNetworkDiskCache> dk(new QNetworkDiskCache);
    dk->setCacheDirectory(qmlCacheDir->absolutePath());

    delete dataDir;
    delete cacheDir;
    delete qmlCacheDir;

    QScopedPointer<Configuration> config(new Configuration);

    if (!config->language().isEmpty()) {
        QLocale::setDefault(QLocale(config->language()));
    } else {
        QLocale::setDefault(QLocale::system());
    }

#ifndef CLAZY
    const QString l10nDir = SailfishApp::pathTo(QStringLiteral("l10n")).toString(QUrl::RemoveScheme);
#else
    const QString l10nDir;
#endif

    QTranslator *appTrans = new QTranslator(app.data());
    if (Q_LIKELY(appTrans->load(QLocale(), QStringLiteral("intfuorit"), QStringLiteral("_"), l10nDir, QStringLiteral(".qm")))) {
        app->installTranslator(appTrans);
    }

    QTranslator *libTrans = new QTranslator(app.data());
    if (Q_LIKELY(libTrans->load(QLocale(), QStringLiteral("libintfuorit"), QStringLiteral("_"), l10nDir, QStringLiteral(".qm")))) {
        app->installTranslator(libTrans);
    }

    qmlRegisterType<Intfuorit::Error>("harbour.intfuorit", 1, 0, "IntfuoritError");
    qmlRegisterType<Intfuorit::Breach>("harbour.intfuorit", 1, 0, "Breach");
    qmlRegisterType<Intfuorit::BreachesListModel>("harbour.intfuorit", 1, 0, "BreachesListModel");
    qmlRegisterType<Intfuorit::BreachesListFilterModel>("harbour.intfuorit", 1, 0, "BreachesListFilterModel");
    qmlRegisterType<Intfuorit::Paste>("harbour.intfuorit", 1, 0, "Paste");
    qmlRegisterType<Intfuorit::PastesListModel>("harbour.intfuorit", 1, 0, "PastesListModel");

#ifndef CLAZY
    QScopedPointer<QQuickView> view(SailfishApp::createView());
#else
    QScopedPointer<QQuickView> view(new QQuickView);
#endif

    QScopedPointer<QQmlNetworkAccessManagerFactory> qmlNamFactory(new NamFactory(dk.data()));
    view->engine()->setNetworkAccessManagerFactory(qmlNamFactory.data());

    view->rootContext()->setContextProperty(QStringLiteral("config"), config.data());
    view->rootContext()->setContextProperty(QStringLiteral("intfuoritUserAgent"), QStringLiteral("Intfuorit %1 - SailfishOS Pwnage Checker").arg(QGuiApplication::applicationVersion()));

#ifndef CLAZY
    view->setSource(SailfishApp::pathTo(QStringLiteral("qml/harbour-intfuorit.qml")));
#endif

    view->show();

    return app->exec();
}
