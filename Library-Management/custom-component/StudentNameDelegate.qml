import QtQuick 2.9
import QtQuick.Controls 2.3
import "../JS/logic.js" as LOGIC

Rectangle {
    id: delegate_root
    property bool m_hovered: false
    property color normalColor: "white"
    property color hoveredColor: "#1A000000"
    property color textColor: "#0A79DF"
    property string studentName: ""
    property string studentDepartment: "department"
    property string sid: ""
    signal clicked
    width: 200
    height: 45
    radius: 5
    color: m_hovered?hoveredColor:normalColor
    Column {
        anchors.centerIn: parent
        Text {
            id: sname
            color: textColor
            font.bold: true
            text: name
        }
        Text {
            id: dname
            color: "grey"
            text: department
            font.pointSize: 10
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {m_hovered = true}
        onExited: {m_hovered = false}
        cursorShape: Qt.PointingHandCursor
        onClicked: delegate_root.clicked()
    }
}
