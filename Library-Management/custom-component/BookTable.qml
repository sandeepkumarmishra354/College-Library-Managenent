import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0

TableView {
    id: book_table
    TableViewColumn {
        role: "bookName"
        title: "Book"
        width: book_table.width/2
    }
    TableViewColumn {
        role: "issueDate"
        title: "Date"
        width: book_table.width/2
    }
    headerDelegate: Rectangle {
        height: textItem.implicitHeight * 2
        width: textItem.implicitWidth
        color: "#E74292"
        Text {
            id: textItem
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: styleData.value
            elide: Text.ElideRight
            font.bold: true
            color: "white"
            renderType: Text.NativeRendering
        }
        Rectangle {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 1
            anchors.topMargin: 1
            width: 1
            color: "white"
        }
    }
    itemDelegate: Component {
        Rectangle {
            width: book_table.width/2
            Rectangle {
                id: itm_rect
                anchors.fill: parent
                property color t_color: (styleData.row % 2 === 0)?"white":"#EAF0F1"
                color: styleData.selected?"#487EB0":t_color
                Text {
                    id: textItem2
                    anchors.topMargin: 10
                    anchors.bottomMargin: 10
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: styleData.value
                    elide: Text.ElideRight
                    font.bold: true
                    color: styleData.selected?"white":"#0A3D62"
                    renderType: Text.NativeRendering
                }
            }
            DropShadow {
                anchors.fill: itm_rect
                source: itm_rect
                radius: styleData.selected ? 8.0 : 0.0
                horizontalOffset: 3
                verticalOffset: 3
                color: "#7B8788"
            }
        }
    }
    rowDelegate: Component {
        Rectangle {
            height: book_table.height/10
        }
    }
}
