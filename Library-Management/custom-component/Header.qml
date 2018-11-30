import QtQuick 2.9
import QtQuick.Controls 2.3
import com.json.userdetails.db 1.0
import "../JS/logic.js" as LOGIC

Rectangle {
    property bool addm_show: false
    property bool mop_show: false
    property string lin_user: ""
    property UserDetailsDb judb: null
    Component.onCompleted: {
        if(judb !== null)
            lin_user = judb.getLoggedInUser()
    }

    AddNewStudentPopUp {
        id: add_popup
        x: Math.round((parent.parent.width - width)/2)
        y: Math.round((parent.parent.height - height)/2)
    }

    id: root
    color: "white"
    width: main_rect.width
    height: 50
    anchors.top: parent.top
    TextField {
        id: search_field
        placeholderText: qsTr("search\t\t\t")
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        background: Rectangle {
            radius: 10
            width: 200
            color: "#DAE0E2"
            border.color: search_field.focus?"#E74292":"#EEC213"
        }
        ToolTip.visible: hovered
        ToolTip.timeout: 3000
        ToolTip.text: qsTr("Search students")
    }
    Image {
        id: add_more_img
        width: 40
        height: 40
        anchors.right: more_op_img.left
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/assets/add-more.png"
        mipmap: true
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onEntered: {addm_show = true}
            onExited: {addm_show = false}
            onClicked: add_popup.open()
        }
        ToolTip.visible: addm_show
        ToolTip.timeout: 3000
        ToolTip.text: qsTr("Add new record")
    }
    Text {
        text: qsTr("Admin: "+lin_user.toUpperCase())
        font.bold: true
        color: "blue"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: add_more_img.left
        anchors.rightMargin: 40
    }

    Image {
        id: more_op_img
        width: 28
        height: 23
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/assets/menu-option.png"
        mipmap: true
        MouseArea {
            anchors.fill: parent
            onClicked: context_menu.popup()
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onEntered: {mop_show = true}
            onExited: {mop_show = false}
        }
        ToolTip.visible: mop_show
        ToolTip.timeout: 3000
        ToolTip.text: qsTr("More")
    }
    Menu {
        id: context_menu
        //MenuItem{text: "settings"}
        //MenuItem{text: "account"}
        //MenuSeparator{}
        MenuItem {
            text: "logout"
            onTriggered: LOGIC.doLogout()
        }
    }
}
