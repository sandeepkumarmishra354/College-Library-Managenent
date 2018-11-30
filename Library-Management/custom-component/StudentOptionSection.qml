import QtQuick 2.9
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import com.json.userdetails.db 1.0

Rectangle {
    id: user_options_rect
    height: 50
    color: "#2B2B52"
    Text {
        text: qsTr("Student name")
        font.bold: true
        color: "white"
        font.pointSize: 20
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
    }

}
