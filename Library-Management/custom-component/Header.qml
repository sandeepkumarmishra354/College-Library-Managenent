import QtQuick 2.9
import QtQuick.Controls 2.3
import com.json.userdetails.db 1.0
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2
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
    MessageDialog {
        id: msg_dialog
        title: qsTr("Logout")
        text: qsTr("Are you sure...")
        icon: StandardIcon.Question
        standardButtons: MessageDialog.Yes | MessageDialog.No
        onYes: LOGIC.doLogout()
        onNo: close()
    }

    id: root
    color: "white"
    width: main_rect.width
    height: 50
    anchors.top: parent.top
    TextField {
        id: search_field
        width: 200
        anchors.left: parent.left
        anchors.leftMargin: 10
        placeholderText: qsTr("search...")
        anchors.verticalCenter: parent.verticalCenter
        background: Rectangle {
            radius: 10
            color: "#DAE0E2"
            border.color: search_field.focus?"#E74292":"#EEC213"
        }
        onTextChanged: {
            if(text == " ")
                clear()
            else
            {
                var last_index = text.length-1
                if(text[last_index] === " " && text[--last_index] === " ")
                    text = text.slice(0,-1)
                search_icon.search_text = text
            }
        }
        ToolTip.visible: hovered
        ToolTip.timeout: 3000
        ToolTip.text: qsTr("Search students")
    }
    Image {
        id: search_icon
        property string search_text: ""
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: search_field.right
        anchors.leftMargin: 8
        source: "qrc:/assets/search-icn-2.png"
        width: search_field.height
        height: width
        mipmap: true
        enabled: false
        opacity: 0.5
        onSearch_textChanged: {
            if(search_text === "")
            {
                enabled = false
                opacity = 0.5
            }
            else
            {
                enabled = true
                opacity = 1.0
            }
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if(parent.search_text !== "")
                    console.log(parent.search_text)
            }
        }
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
            onTriggered: msg_dialog.open()
        }
    }
}
