import QtQuick 2.0
import QtQuick.Controls 2.2

Button {
    id: control
    text: qsTr("Button")
    property color buttonColor: "grey"
    property color pressedColor: "#2F363F"
    property color textColor: "white"

    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        id: b_r
        color: control.down ? pressedColor : buttonColor
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        radius: 10
    }
    onHoveredChanged: hovered?b_r.color=pressedColor:b_r.color=buttonColor
}
