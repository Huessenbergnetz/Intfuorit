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
#include "intfuoriticonprovider.h"
#endif
#include "hbnsciconprovider.h"

#include <Intfuorit/Error>
#include <Intfuorit/Objects/Breach>
#include <Intfuorit/Models/BreachesListModel>
#include <Intfuorit/Models/BreachesListFilterModel>
#include <Intfuorit/Objects/Paste>
#include <Intfuorit/Models/PastesListModel>

#include "../../common/configuration.h"
#include "../../common/namfactory.h"
#include "../../common/languagemodel.h"
#include "../../common/cacheperiodmodel.h"

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

    auto config = new Configuration(app.data());

    if (!config->language().isEmpty()) {
        QLocale::setDefault(QLocale(config->language()));
    } else {
        QLocale::setDefault(QLocale::system());
    }

    QScopedPointer<QNetworkDiskCache> dk(new QNetworkDiskCache);

    {
        QDir dataDir(QStandardPaths::writableLocation(QStandardPaths::DataLocation));
        QDir cacheDir(QStandardPaths::writableLocation(QStandardPaths::CacheLocation));
        QDir qmlCacheDir(cacheDir.absolutePath() + QStringLiteral("/qmlcache"));

        if (Q_UNLIKELY(!dataDir.exists())) {
            if (Q_UNLIKELY(!dataDir.mkpath(dataDir.absolutePath()))) {
                qFatal("Failed to create data directory.");
            }
        }

        if (Q_UNLIKELY(!cacheDir.exists())) {
            if (Q_UNLIKELY(!cacheDir.mkpath(cacheDir.absolutePath()))) {
                qFatal("Failed to create cache directory.");
            }
        }

        if (Q_UNLIKELY(!qmlCacheDir.exists())) {
            if (Q_UNLIKELY(!qmlCacheDir.mkpath(qmlCacheDir.absolutePath()))) {
                qFatal("Failed to create qml cache directory.");
            }
        }

        dk->setCacheDirectory(qmlCacheDir.absolutePath());
    }

    {
#ifndef CLAZY
        const QString l10nDir = SailfishApp::pathTo(QStringLiteral("l10n")).toString(QUrl::RemoveScheme);
#else
        const QString l10nDir;
#endif
        qDebug("Loading translations from %s", qUtf8Printable(l10nDir));
        const QLocale locale;

        for (const QString &name : {QStringLiteral("intfuorit"), QStringLiteral("libintfuorit"), QStringLiteral("hbnsc")}) {
            auto trans = new QTranslator(app.data());
            if (Q_LIKELY(trans->load(locale, name, QStringLiteral("_"), l10nDir, QStringLiteral(".qm")))) {
                if (Q_UNLIKELY(!app->installTranslator(trans))) {
                    qWarning("Can not install translator for component \"%s\" and locale \"%s\".", qUtf8Printable(name), qUtf8Printable(locale.name()));
                }
            } else {
                qWarning("Can not load translations for component \"%s\" and locale \"%s\".", qUtf8Printable(name), qUtf8Printable(locale.name()));
            }
        }
    }

    LanguageModel::setSupportedLangs(QStringList({QStringLiteral("en_US"), QStringLiteral("en_GB"), QStringLiteral("de"), QStringLiteral("sv")}));

    qRegisterMetaType<Intfuorit::Error>();
    QMetaType::registerEqualsComparator<Intfuorit::Error>();
    qmlRegisterUncreatableType<Intfuorit::Error>("harbour.intfuorit", 1, 0, "Error", QStringLiteral("Can not create Intfuorit::Error in QML!"));
    qRegisterMetaType<Intfuorit::Breach>();
    QMetaType::registerEqualsComparator<Intfuorit::Breach>();
    qRegisterMetaType<Intfuorit::Paste>();
    QMetaType::registerEqualsComparator<Intfuorit::Paste>();
    qmlRegisterType<Intfuorit::BreachesListModel>("harbour.intfuorit", 1, 0, "BreachesListModel");
    qmlRegisterType<Intfuorit::BreachesListFilterModel>("harbour.intfuorit", 1, 0, "BreachesListFilterModel");
    qmlRegisterType<Intfuorit::PastesListModel>("harbour.intfuorit", 1, 0, "PastesListModel");
    qmlRegisterType<LanguageModel>("harbour.intfuorit", 1, 0, "LanguageModel");
    qmlRegisterType<CachePeriodModel>("harbour.intfuorit", 1, 0, "CachePeriodModel");

#ifndef CLAZY
    QScopedPointer<QQuickView> view(SailfishApp::createView());
    view->engine()->addImageProvider(QStringLiteral("intfuorit"), new IntfuoritIconProvider);
    QScopedPointer<Hbnsc::HbnscIconProvider> hbnscIconProvider(new Hbnsc::HbnscIconProvider(view->engine()));
#else
    QScopedPointer<QQuickView> view(new QQuickView);
#endif

    QScopedPointer<QQmlNetworkAccessManagerFactory> qmlNamFactory(new NamFactory(dk.data()));
    view->engine()->setNetworkAccessManagerFactory(qmlNamFactory.data());

    view->rootContext()->setContextProperty(QStringLiteral("config"), config);
    view->rootContext()->setContextProperty(QStringLiteral("intfuoritUserAgent"), QStringLiteral("Intfuorit %1 - SailfishOS Pwnage Checker").arg(QGuiApplication::applicationVersion()));

#ifndef CLAZY
    view->setSource(SailfishApp::pathToMainQml());
#endif

    view->show();

    return app->exec();
}
