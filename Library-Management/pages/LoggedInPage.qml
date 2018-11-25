import QtQuick 2.9
import QtQuick.Controls 2.3
import "../custom-component"

Item {
    property string username: "sandeep"
    Rectangle {
        width: parent.width
        height: parent.height
        Text {
            anchors.centerIn: parent
            text: qsTr(username)
        }
    }
}
