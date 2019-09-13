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

#ifndef CONFIGURATION_H
#define CONFIGURATION_H

#include <QObject>
#include <QSettings>

class Configuration : public QSettings
{
    Q_OBJECT
    Q_DISABLE_COPY(Configuration)
    /*!
     * This property holds the stored display language. The default value is empty.
     *
     * \par Access functions:
     * \li QString language() const
     * \li QString setLanguage(const QString &nLanguage)
     *
     * \par Notifier signal:
     * \li void languageChanged(const QString &language)
     */
    Q_PROPERTY(QString language READ language WRITE setLanguage NOTIFY languageChanged)
    Q_PROPERTY(QString apiKey READ apiKey WRITE setApiKey NOTIFY apiKeyChanged)
    /*!
     * This property holds the stored cache period in seconds. The default value is 2 days.
     *
     * \par Access functions:
     * \li quint32 cachePeriod() const
     * \li void setCachePeriod(quint32 nCachePeriod)
     *
     * \par Notifier signal:
     * \li void cachePeriodChanged(quint32 cachePeriod)
     */
    Q_PROPERTY(quint32 cachePeriod READ cachePeriod WRITE setCachePeriod NOTIFY cachePeriodChanged)
    /*!
     * This property is \c true if it is the first start of the application.
     *
     * \par Access functions:
     * bool firstStart() const
     * void setFirstStart(bool nFirstStart)
     *
     * \par Notifier signal:
     * void firstStartChanged(bool firstStart)
     */
    Q_PROPERTY(bool firstStart READ firstStart WRITE setFirstStart NOTIFY firstStartChanged)
    /*!
     * This property is \c true if unverified breaches should be included in the account search.
     *
     * \par Access functions:
     * bool includeUnverified() const
     * void setIncludeUnverified(bool nIncludeUnverified)
     *
     * \par Notifier signal:
     * void includeUnverifiedChanged(bool includeUnverified)
     */
    Q_PROPERTY(bool includeUnverified READ includeUnverified WRITE setIncludeUnverified NOTIFY includeUnverifiedChanged)
public:
    /*!
     * Constructs a new Configuration object with the given \a parent.
     */
    explicit Configuration(QObject *parent = nullptr);

    /*!
     * \brief Deconstructs the Configuration object.
     */
     ~Configuration();

    /*!
     * Getter function for the \link Configuration::language language \endlink property.
     * \sa setLanguage(), languageChanged()
     */
    QString language() const;

    QString apiKey() const;

    /*!
     * Getter function for the \link Configuration::cachePeriod cachePeriod \endlink property.
     * \sa setCachePeriod(), cachePeriodChanged()
     */
    quint32 cachePeriod() const;

    /*!
     * Getter function for the \link Configuration::firstStart firstStart \endlink property.
     * \sa setFirstStart(), firstStartChanged()
     */
    bool firstStart() const;

    /*!
     * Getter function for the \link Configuration::includeUnverified includeUnverified \endlink property.
     * \sa setIncludeUnverified(), includeUnverifiedChanged()
     */
    bool includeUnverified() const;


    /*!
     * Setter function for the \link Configuration::language language \endlink property.
     * \sa language(), languageChanged()
     */
    void setLanguage(const QString &nLanguage);

    void setApiKey(const QString &nApiKey);

    /*!
     * Setter function for the \link Configuration::cachePeriod cachePeriod \endlink property.
     * \sa cachePeriod(), cachePeriodChanged()
     */
    void setCachePeriod(quint32 nCachePeriod);

    /*!
     * Setter function for the \link Configuration::firstStart firstStart \endlink property.
     * \sa firstStart(), firstStartChanged()
     */
    void setFirstStart(bool nFirstStart);

    /*!
     * Setter function for the \link Configuration::includeUnverified includeUnverified \endlink property.
     * \sa includeUnverified(), includeUnverifiedChanged()
     */
    void setIncludeUnverified(bool nIncludeUnverified);

signals:
    /*!
     * Notifier function for the \link Configuration::language language \endlink property.
     * \sa setLanguage(), language()
     */
    void languageChanged(const QString &language);

    void apiKeyChanged(const QString &apiKey);

    /*!
     * Notifier signal for the \link Configuration::cachePeriod cachePeriod \endlink property.
     * \sa cachePeriod(), setCachePeriod()
     */
    void cachePeriodChanged(quint32 cachePeriod);

    /*!
     * Notifier signal for the \link Configuration::firstStart firstStart \endlink property.
     * \sa firstStart(), setFirstStart()
     */
    void firstStartChanged(bool firstStart);

    /*!
     * Notifier signal for the \link Configuration::includeUnverified includeUnverified \endlink property.
     * \sa includeUnverified(), setIncludeUnverified()
     */
    void includeUnverifiedChanged(bool includeUnverified);

private:
    QString encPw(const QString &pw) const;
    QString decPw(const QString &pw) const;

    QString m_language;
    QString m_apiKey;
    quint32 m_cachePeriod = 3600*48;
    bool m_firstStart = true;
    bool m_includeUnverified = false;
};

#endif // CONFIGURATION_H
