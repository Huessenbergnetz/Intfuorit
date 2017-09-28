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

import QtQuick 2.6

ListModel {
    id: hm

    ListElement {
        header: true
        //% "What does HIBP stand for?"
        text: qsTrId("intfuroit-help-a-head")
    }

    ListElement {
        //% "HIBP is the abbreviation for “Have I been Pwned?”, a website created by Troy Hunt that allows internet users to check if their personal data has been compromised by data breaches. The service collects and analyzes dozens of database dumps and pastes containing information about hundreds of millions of leaked accounts, and allows users to search for their own information by entering their username or email address."
        text: qsTrId("intfuorit-help-a-text")
    }

    ListElement {
        header: true
        //% "What is a “breach” and where has the data come from?"
        text: qsTrId("intfuorit-help-0-head")
    }

    ListElement {
        //% "A “breach” is an incident where a hacker illegally obtains data from a vulnerable system, usually by exploiting weaknesses in the software. All the data on haveibeenpwned.com comes from website breaches which have been made publicly available."
        text: qsTrId("intfuorit-help-0-text")
    }

    ListElement {
        header: true
        //% "How is a breach verified as legitimate?"
        text: qsTrId("intfuorit-help-1-head")
    }

    ListElement {
        //% "There are often “breaches” announced by attackers which in turn are exposed as hoaxes. There is a balance between making data searchable early and performing sufficient due diligence to establish the legitimacy of the breach. The following activities are usually performed by Troy Hunt in order to validate breach legitimacy:<ol><li>Has the impacted service publicly acknowledged the breach?</li><li>Does the data in the breach turn up in a Google search (i.e. it’s just copied from another source)?</li><li>Is the structure of the data consistent with what you’d expect to see in a breach?</li><li>Have the attackers provided sufficient evidence to demonstrate the attack vector?</li><li>Do the attackers have a track record of either reliably releasing breaches or falsifying them?</li></ol>"
        text: qsTrId("intfuorit-help-1-text")
        format: Text.RichText
    }

    ListElement {
        header: true
        //% "My email was reported as appearing in a paste but the paste now can’t be found"
        text: qsTrId("intfuorit-help-2-head")
    }

    ListElement {
        //% "Pastes are often transient; they appear briefly and are then removed. HIBP usually indexes a new paste within 40 seconds of it appearing and stores the email addresses that appeared in the paste along with some meta data such as the date, title and author (if they exist). The paste itself is not stored and cannot be displayed if it no longer exists at the source."
        text: qsTrId("intfuorit-help-2-text")
    }

    ListElement {
        header: true
        //% "My email was not found — does that mean I haven’t been pwned?"
        text: qsTrId("intfuorit-help-3-head")
    }

    ListElement {
        //% "Whilst HIBP is kept up to date with as much data as possible, it contains but a small subset of all the records that have been breached over the years. Many breaches never result in the public release of data and indeed many breaches even go entirely undetected. “Absence of evidence is not evidence of absence” or in other words, just because your email address wasn’t found here doesn’t mean that it hasn’t been compromised in another breach."
        text: qsTrId("intfuorit-help-3-text")
    }

    ListElement {
        header: true
        //% "Why do I see my username as breached on a service I never signed up to?"
        text: qsTrId("intfuorit-help-4-head")
    }

    ListElement {
        //% "When you search for a username that is not an email address, you may see that name appear against breaches of sites you never signed up to. Usually this is simply due to someone else electing to use the same username as you usually do. Even when your username appears very unique, the simple fact that there are several billion internet users worldwide means there’s a strong probability that most usernames have been used by other individuals at one time or another."
        text: qsTrId("intfuorit-help-4-text")
    }

    ListElement {
        header: true
        //% "Why do I see my email address as breached on a service I never signed up to?"
        text: qsTrId("intfuorit-help-5-head")
    }

    ListElement {
        //index: 13
        text: ""
        format: Text.StyledText
    }

    ListElement {
        header: true
        //% "What is a sensitive breach?"
        text: qsTrId("intfuorit-help-6-head")
    }

    ListElement {
        //% "HIBP enables you to discover if your account was exposed in most of the data breaches by directly searching the system. However, certain breaches are particularly sensitive in that someone’s presence in the breach may adversely impact them if others are able to find that they were a member of the site. These breaches are classed as “sensitive” and may not be publicly searched."
        text: qsTrId("intfuorit-help-6-text-1")
    }

    ListElement {
        //index: 16
        text: ""
        format: Text.StyledText
    }

    ListElement {
        header: true
        //% "What is a retired breach?"
        text: qsTrId("intfuorit-help-7-head")
    }

    ListElement {
        //% "After a security incident which results in the disclosure of account data, the breach may be loaded into HIBP where it then sends notifications to impacted subscribers and becomes searchable. In very rare circumstances, that breach may later be permanently removed from HIBP where it is then classed as a “retired breach”."
        text: qsTrId("intfuorit-help-7-text-1")
    }

    ListElement {
        //index: 19
        text: ""
        format: Text.StyledText
    }

    ListElement {
        header: true
        //% "What is an unverified breach?"
        text: qsTrId("intfuorit-help-8-head")
    }

    ListElement {
        //index: 21
        text: ""
        format: Text.StyledText
    }

    ListElement {
        header: true
        //% "What is a fabricated breach?"
        text: qsTrId("intfuorit-help-9-head")
    }

    ListElement {
        //index: 23
        text: ""
        format: Text.StyledText
    }

    ListElement {
        header: true
        //% "What is a spam list?"
        text: qsTrId("intfuorit-help-10-head")
    }

    ListElement {
        //index: 25
        text: ""
        format: Text.StyledText
    }

    ListElement {
        header: true
        //% "Where can I get more information?"
        text: qsTrId("intfuorit-help-11-head")
    }

    ListElement {
        //index: 27
        text: ""
        format: Text.StyledText
    }

    Component.onCompleted: {
        //% "When you search for an email address, you may see that address appear against breaches of sites you don’t recall ever signing up to. There are many possible reasons for this including your data having been acquired by another service, the service rebranding itself as something else or someone else signing you up. For a more comprehensive overview, see %1"
        hm.get(13).text = qsTrId("intfuorit-help-5-text").arg("<a href='https://www.troyhunt.com/why-am-i-in-a-data-breach-for-a-site-i-never-signed-up-for/'>Why am I in a data breach for a site I never signed up to?</a>")

        //% "A sensitive data breach can only be searched by the <i>verified owner</i> of the email address being searched for. This is done via <a href='%1'>the notification system on haveibeenpwned.com</a> which involves sending a verification email to the address with a unique link. When that link is followed, the owner of the address will see <i>all</i> data breaches and pastes they appear in, including the sensitive ones."
        hm.get(16).text = qsTrId("intfuorit-help-6-text-2").arg("https://haveibeenpwned.com/NotifyMe")

        //% "A retired breach is typically one where the data does not appear in other locations on the web, that is it’s not being traded or redistributed. Deleting it from HIBP provides those impacted with assurance that their data can no longer be found in any remaining locations. For more background, read %1."
        hm.get(19).text = qsTrId("intfuorit-help-7-text-2").arg("<a href='https://www.troyhunt.com/have-i-been-pwned-opting-out-vtech-and/'>Have I been pwned, opting out, VTech and general privacy things</a>")

        //% "Some breaches may be flagged as “unverified”. In these cases, whilst there is legitimate data within the alleged breach, it may not have been possible to establish legitimacy beyond reasonable doubt. Unverified breaches are still included in the system because regardless of their legitimacy, they still contain personal information about individuals who want to understand their exposure on the web. Further background on unverified breaches can be found in the blog post titled %1."
        hm.get(21).text = qsTrId("intfuorit-help-8-text").arg("<a href='https://www.troyhunt.com/introducing-unverified-breaches-to-have-i-been-pwned'>Introducing unverified breaches to Have I been pwned</a>")

        //% "Some breaches may be flagged as “fabricated”. In these cases, it is highly unlikely that the breach contains legitimate data sourced from the alleged site but it may still be sold or traded under the auspices of legitimacy. Often these incidents are comprised of data aggregated from other locations (or may be entirely fabricated), yet still contain actual email addresses of unbeknownst to the account holder. Fabricated breaches are still included in the system because regardless of their legitimacy, they still contain personal information about individuals who want to understand their exposure on the web. Further background on unverified breaches can be found in the blog post titled %1."
        hm.get(23).text = qsTrId("intfuorit-help-9-text").arg("<a href='https://www.troyhunt.com/introducing-fabricated-data-breaches-to-have-i-been-pwned'>Introducing “fabricated” breaches to Have I been pwned</a>")

        //% "Occasionally, large volumes of personal data are found being utilised for the purposes of sending targeted spam. This often includes many of the same attributes frequently found in data breaches such as names, addresses, phones numbers and dates of birth. The lists are often aggregated from multiple sources, <a href='%1'>frequently by eliciting personal information from people with the promise of a monetary reward</a>. Whilst the data may not have been sourced from a breached system, the personal nature of the information and the fact that it's redistributed in this fashion unbeknownst to the owners warrants inclusion here. <a href='%2'>Read more about spam lists in HIBP</a>."
        hm.get(25).text = qsTrId("intfuorit-help-10-text").arg("https://www.troyhunt.com/have-i-been-pwned-and-spam-lists-of-personal-information").arg("https://www.troyhunt.com/have-i-been-pwned-and-spam-lists-of-personal-information")

        //% "Read the <a href='%1'>full FAQ</a> on haveibeenpwned.com or visit <a href='%2'>Troy Hunt’s blog</a> to learn more about it."
        hm.get(27).text = qsTrId("intfuorit-help-11-text").arg("https://haveibeenpwned.com/FAQs").arg("https://www.troyhunt.com/tag/have-i-been-pwned-3f/")
    }
}
