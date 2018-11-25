import QtQuick 2.0
import QtQuick.Controls 2.2

Button {
    id: control
    text: qsTr("Button")
    property color buttonColor: "grey"
    property color pressedColor: "#2F363F"

    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        color: control.down ? pressedColor : buttonColor
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        radius: 10
    }
}
