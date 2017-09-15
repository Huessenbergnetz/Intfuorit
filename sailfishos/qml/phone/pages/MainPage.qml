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
            Layout.preferredWidth: mainPage.isLandscape ? (mainPageSorting.width/4) : (mainPageSorting.width/2)
            ComboBox {
                id: sortChooser
                //% "Sort by"
                label: qsTrId("intfuorit-sort-by-label")
                menu: ContextMenu {
                    //% "Title"
                    MenuItem { text: qsTrId("intfuorit-sort-role-title"); readonly property int value: BreachesListModel.Title }
                    //% "Count"
                    MenuItem { text: qsTrId("intfuorit-sort-role-pwncount"); readonly property int value: BreachesListModel.PwnCount }
                }
                onCurrentIndexChanged: if (currentItem) { blfm.sortRole = currentItem.value }
                currentIndex: 1
            }
        }

        TextSwitch {
            id: orderChooser
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.preferredWidth: mainPage.isLandscape ? (mainPageSorting.width/4) : (mainPageSorting.width/2)
            //% "Descending"
            text: qsTrId("intfuorit-order-descending")
            checked: blfm.sortOrder == Qt.DescendingOrder
            onCheckedChanged: blfm.sortOrder = (checked ? Qt.DescendingOrder : Qt.AscendingOrder)
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
                //% "About"
                text: qsTrId("intfuorit-about")
            }
            MenuItem {
                //% "Settings"
                text: qsTrId("intfuorit-settings")
            }
            MenuItem {
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
            enabled: !blfm.error && !blfm.inOperation && !breachesGridView.count
            //% "Nothing found"
            text: qsTrId("intfuorit-nothing-found")
            //% "There is no breached site matching your filter."
            hintText: qsTrId("intfuorit-nothing-found-hint")
        }

        ViewPlaceholder {
            id: errorPh
            enabled: !blfm.inOperation && blfm.error && (blfm.error.type !== IntfuoritError.NoError)
            //% "Error"
            text: qsTrId("intfuorit-error")
            hintText: blfm.error ? blfm.error.text : ""
        }
    }
}
