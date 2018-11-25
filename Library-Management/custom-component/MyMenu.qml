import QtQuick 2.9
import QtQuick.Controls 2.3
MenuBar {
    Menu {
        title: qsTr("&File")
        Action { text: qsTr("&New") }
        Action { text: qsTr("&Open") }
        Action { text: qsTr("&Save") }
        Action { text: qsTr("Save &As") }
        MenuSeparator {}
        Action {
            text: qsTr("&Quit")
            onTriggered: Qt.quit()
        }
    }
    Menu {
        title: qsTr("&Help")
        Action { text: qsTr("&About Qt") }
        Action { text: qsTr("&About") }
    }
}
