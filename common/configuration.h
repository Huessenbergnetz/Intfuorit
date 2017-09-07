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

#ifndef CONFIGURATION_H
#define CONFIGURATION_H

#include <QObject>
#include <QSettings>

class Configuration : public QSettings
{
    Q_OBJECT
    Q_DISABLE_COPY(Configuration)
    /*!
     * \brief Stores the user defined language.
     *
     * \par Access functions:
     * \li QString language() const
     * \li QString setLanguage(const QString &nLanguage)
     *
     * \par Notifier signal:
     * \li void languageChanged(const QString &language)
     */
    Q_PROPERTY(QString language READ language WRITE setLanguage NOTIFY languageChanged)
public:
    /*!
     * \brief Constructs a new Configuration object with the given \a parent.
     */
    explicit Configuration(QObject *parent = nullptr);

    /*!
     * \brief Deconstructs the Configuration object.
     */
     ~Configuration();

    /*!
     * \brief Getter function for the \link Configuration::language language \endlink property.
     * \sa Configuration::setLanguage() Configuration::languageChanged()
     */
    QString language() const;


    /*!
     * \brief Setter function for the \link Configuration::language language \endlink property.
     * \sa Configuration::language() Configuration::languageChanged()
     */
    void setLanguage(const QString &nLanguage);

signals:
    /*!
     * \brief Notifier function for the \link Configuration::language language \endlink property.
     * \sa Confiuration::setLanguage() Configuration::language()
     */
    void languageChanged(const QString &language);

private:
    QString m_language;
};

#endif // CONFIGURATION_H
