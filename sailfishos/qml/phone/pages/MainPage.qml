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
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0
import de.huessenbergnetz.intfuorit 1.0
import harbour.intfuorit 1.0

Page {
    id: mainPage

    allowedOrientations: Orientation.All

    onStatusChanged: {
        if ((status == PageStatus.Active) && !mainPage.canNavigateForward) {
            pageStack.pushAttached(Qt.resolvedUrl("BreachSearchPage.qml"))
        }
    }

    Label {
        id: dummyCount
        visible: false
        text: Number(9999999999).toLocaleString(Qt.locale(), 'f', 0)
        font.pixelSize: Theme.fontSizeSmall
    }

    GridLayout {
        id: mainPageSorting
        columnSpacing: 0
        rowSpacing: 0

        columns: mainPage.isPortrait ? 2 : 4

        width: mainPage.width

        PageHeader {
            id: mainPageHeader
            title: "Intfuorit"
            //% "All breached sites"
            description: qsTrId("intfuorit-all-breached-sites")
            page: mainPage
            Layout.fillWidth: true
            Layout.columnSpan: mainPageSorting.columns
        }

        SearchField {
            id: mainPageSearch
            Layout.fillWidth: true
            Layout.preferredHeight: mainPageSearch.height
            Layout.columnSpan: 2
            EnterKey.onClicked: mainPageSearch.focus = false
            EnterKey.iconSource: "image://theme/icon-m-enter-close"

            //% "Filter by title or domain"
            placeholderText: qsTrId("intfuorit-filter-title-domain-placeholder")

            Binding {
                target: blfm
                property: "search"
                value: mainPageSearch.text
            }
        }

        Item {
            Layout.preferredHeight: sortChooser.height
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillWidth: true
            Layout.columnSpan: 2
            ComboBox {
                id: sortChooser
                //: Label for a combobox (drop down menu), value will be something like: Title (ascending)
                //% "Sort by"
                label: qsTrId("intfuorit-sort-by-label")
                menu: ContextMenu {
                    //: Value in a combobox (drop down menu)
                    //% "Title (ascending)"
                    MenuItem { text: qsTrId("intfuorit-sort-by-title-asc"); readonly property int role: BreachesListModel.Title; readonly property int order: Qt.AscendingOrder }
                    //: Value in a combobox (drop down menu)
                    //% "Title (descending)"
                    MenuItem { text: qsTrId("intfuorit-sort-by-title-desc"); readonly property int role: BreachesListModel.Title; readonly property int order: Qt.DescendingOrder }
                    //: Value in a combobox (drop down menu)
                    //% "Count (ascending)"
                    MenuItem { text: qsTrId("intfuorit-sort-by-count-asc"); readonly property int role: BreachesListModel.PwnCount; readonly property int order: Qt.AscendingOrder }
                    //: Value in a combobox (drop down menu)
                    //% "Count (descending)"
                    MenuItem { text: qsTrId("intfuorit-sort-by-count-desc"); readonly property int role: BreachesListModel.PwnCount; readonly property int order: Qt.DescendingOrder }
                    //: Value in a combobox (drop down menu)
                    //% "Breach date (ascending)"
                    MenuItem { text: qsTrId("intfuorit-sort-by-breachdate-asc"); readonly property int role: BreachesListModel.BreachDate; readonly property int order: Qt.AscendingOrder }
                    //: Value in a combobox (drop down menu)
                    //% "Breach date (descending)"
                    MenuItem { text: qsTrId("intfuorit-sort-by-breachdate-desc"); readonly property int role: BreachesListModel.BreachDate; readonly property int order: Qt.DescendingOrder }
                    //: Value in a combobox (drop down menu)
                    //% "Added date (ascending)"
                    MenuItem { text: qsTrId("intfuorit-sort-by-addeddate-asc"); readonly property int role: BreachesListModel.AddedDate; readonly property int order: Qt.AscendingOrder }
                    //: Value in a combobox (drop down menu)
                    //% "Added date (descending)"
                    MenuItem { text: qsTrId("intfuorit-sort-by-addeddate-desc"); readonly property int role: BreachesListModel.AddedDate; readonly property int order: Qt.DescendingOrder }
                }
                onCurrentIndexChanged: if (currentItem) { blfm.sortRole = currentItem.role; blfm.sortOrder = currentItem.order }
                currentIndex: 7
            }
        }
    }

    SilicaGridView {
        id: breachesGridView
        anchors.fill: parent
        currentIndex: -1

        Component.onCompleted: {
            blfm.getAllBreaches()
        }

        cellWidth: breachesGridView.width / (mainPage.isLandscape ? 2 : 1)
        cellHeight: Theme.itemSizeMedium

        PullDownMenu {
            MenuItem {
                //: Pull down menu entry and page header
                //% "About"
                text: qsTrId("intfuorit-about")
                onClicked: pageStack.push(Qt.resolvedUrl("../../common/pages/About.qml"))
            }
            MenuItem {
                //: Pull down menu entry and page header
                //% "Help/FAQ"
                text: qsTrId("intfuorit-help-faq")
                onClicked: pageStack.push(Qt.resolvedUrl("../../common/pages/Help.qml"))
            }
            MenuItem {
                //: Pull down menu entry and page header
                //% "Settings"
                text: qsTrId("intfuorit-settings")
                onClicked: pageStack.push(Qt.resolvedUrl("../../common/pages/Settings.qml"))
            }
            MenuItem {
                //: Pull down menu entry
                //% "Reload"
                text: qsTrId("intfuorit-reload")
                onClicked: blfm.getAllBreaches(true)
            }
        }

        header: Item {
            id: header
            width: mainPageSorting.width
            height: mainPageSorting.height
            Component.onCompleted: mainPageSorting.parent = header
        }


        VerticalScrollDecorator {
            flickable: breachesGridView
            page: mainPage
        }

        model: BreachesListFilterModel {
            id: blfm
            userAgent: intfuoritUserAgent
            cachePeriod: 86400
        }

        delegate: BreachesListDelegate {
            id: breachesListItem
            searchTerm: blfm.search
            countWidth: dummyCount.width
            width: breachesGridView.cellWidth
//            GridView.onAdd: AddAnimation {
//                target: breachesListItem
//            }

//            GridView.onRemove: RemoveAnimation {
//                target: breachesListItem
//            }
        }

        BusyIndicator {
            anchors.centerIn: parent
            size: BusyIndicatorSize.Large
            running: visible
            visible: blfm.inOperation
        }

        ViewPlaceholder {
            id: emptyListVp
            enabled: !blfm.inOperation && !breachesGridView.count && blfm.error.type === Error.NoError
            //% "Nothing found"
            text: qsTrId("intfuorit-nothing-found")
            //% "There is no breached site matching your filter."
            hintText: qsTrId("intfuorit-nothing-found-hint")
        }

        ViewPlaceholder {
            id: errorPh
            enabled: !blfm.inOperation && blfm.error.type !== Error.NoError
            //% "Error"
            text: qsTrId("intfuorit-error")
            hintText: blfm.error.text
        }

        footer: Item {
            width: breachesGridView.width
            height: Theme.itemSizeMedium
            visible: breachesGridView.count > 0
            Text {
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; verticalCenter: parent.verticalCenter }
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignHCenter
                textFormat: Text.StyledText
                //% "Data provided by %1"
                text: qsTrId("intfuorit-hibp-attribution").arg("<a href='https://haveibeenpwned.com'>Have I been pwned?</a>")
                linkColor: Theme.secondaryHighlightColor
                wrapMode: Text.WordWrap
            }
        }
    }
}
