import QtQuick 2.9
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import com.json.db 1.0
import com.json.userdetails.db 1.0
import "../custom-component"
import "../JS/logic.js" as LOGIC

Page {
    id: page_root
    property var decrement: null
    property StackView mainStack: null
    property JsonDb jsondb: null
    property UserDetailsDb jsonuser_db: null
    property bool isCreating: false
    background: Rectangle {
        id: bg_image
        color: "#00000000"
        Rectangle {
            id: ind_rect
            width: 40
            height: 40
            radius: width/2
            color: "#E71C23"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
            RotationAnimation {
                id: r_animation
                target: ind_rect
                from: 0
                to: 360
                duration: 1000
                running: false
            }
            Timer {
                interval: 5000
                running: true
                repeat: true
                onTriggered: r_animation.running = true
            }

            SequentialAnimation on color {
                loops: Animation.Infinite
                ColorAnimation{from:"#E71C23"; to:"#0A79DF";duration: 3000}
                ColorAnimation{to:"#E71C23"; from:"#0A79DF";duration: 3000}
                ColorAnimation{from:"#E71C23"; to:"#45CE30";duration: 3000}
                ColorAnimation{to:"#E71C23"; from:"#BB2CD9";duration: 3000}
            }

            Text {
                text: qsTr("<")
                font.bold: true
                color: "white"
                font.pointSize: 20
                anchors.centerIn: parent
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(decrement != null)
                        decrement()
                }

                cursorShape: Qt.PointingHandCursor
            }
        }
    }

    Rectangle {
        id: page_rect
        property string username_txt: ""
        property string password_txt: ""
        anchors.centerIn: parent
        ErrorDialog{id: dialog}
        color: "#E6000000"
        width: 350.0
        height: 400.0
        Column {
            spacing: 20
            anchors.centerIn: parent
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Create New Account")
                color: "#1287A5"
                font.bold: true
                font.pointSize: 20
            }

            TextField {
                id: username_id
                width: 200
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: "choose username"
                maximumLength: 20
                validator: RegExpValidator {
                    regExp: /^[a-zA-Z0-9]+$/ /*no space allowed */
                }
                onTextChanged: {page_rect.username_txt = text}
            }
            TextField {
                id: password_id
                width: 200
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: "choose password"
                echoMode: TextInput.Password
                maximumLength: 20
                validator: RegExpValidator {
                    regExp: /^[a-zA-Z0-9]+$/ /*no space allowed */
                }
                onTextChanged: {page_rect.password_txt = text}
            }
            MyButton {
                text: "Create"
                enabled: (page_rect.username_txt != "" && page_rect.password_txt.length >=6)
                anchors.horizontalCenter: parent.horizontalCenter
                buttonColor: "#3C40C6"
                pressedColor: "#487EB0"
                onClicked: LOGIC.createAccount()
            }
            MyButton {
                text: "Login"
                anchors.horizontalCenter: parent.horizontalCenter
                buttonColor: "#AE1438"
                pressedColor: "#E71C23"
                onClicked: {
                    if(decrement != null)
                    {
                        username_id.clear()
                        password_id.clear()
                        decrement()
                    }
                }
            }
        }
    }
}
