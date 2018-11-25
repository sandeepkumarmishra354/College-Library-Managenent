import QtQuick 2.9
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import com.json.db 1.0
import "../custom-component"

Page {
    property var showCreateAccPage: null
    property JsonDb jsondb: null
    id: page_root
    background: Image {
        id: bg_image
        source: "qrc:/assets/login-bg.jpg"
    }

    Rectangle {
        id: page_rect
        ErrorDialog{id: dialog}
        property string username_txt: ""
        property string password_txt: ""
        anchors.centerIn: parent
        color: "#E6000000"
        width: 350.0
        height: 400.0
        Column {
            spacing: 20
            anchors.centerIn: parent
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Admin Login Pannel")
                color: "#1287A5"
                font.bold: true
                font.pointSize: 20
            }

            TextField {
                id: username_id
                width: 200
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: "username"
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
                placeholderText: "password"
                echoMode: TextInput.Password
                maximumLength: 20
                validator: RegExpValidator {
                    regExp: /^[a-zA-Z0-9]+$/ /*no space allowed */
                }
                onTextChanged: {page_rect.password_txt = text}
            }
            MyButton {
                text: "Login"
                enabled: (page_rect.username_txt != "" && page_rect.password_txt.length >=6)
                anchors.horizontalCenter: parent.horizontalCenter
                buttonColor: "#3C40C6"
                pressedColor: "#487EB0"
                onClicked: {
                    if(password_id.displayText.length >=6 && username_id.displayText != "")
                    {
                            var st = jsondb.isCorrect(page_rect.username_txt,page_rect.password_txt)
                            if(st)
                            {
                                page_root.parent.push("LoggedInPage.qml",{username:page_rect.username_txt})
                            }
                            else
                            {
                                dialog.text = qsTr("username or password is incorrect")
                                dialog.visible = true
                            }
                    }
                    else
                    {
                        dialog.text = qsTr("password must be 6 character long.\n"+
                                            "And username can't be empty")
                        dialog.visible = true
                    }
                }
            }

            Text {
                id: fg_txt
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("forgot password ?")
                color: "blue"
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {fg_txt.color = "red"}
                    onExited: {fg_txt.color = "blue"}
                    cursorShape: Qt.PointingHandCursor
                }
            }
            MyButton {
                text: "Create Account"
                anchors.horizontalCenter: parent.horizontalCenter
                buttonColor: "#AE1438"
                pressedColor: "#E71C23"
                onClicked: {
                    if(showCreateAccPage != null) {
                        password_id.clear()
                        username_id.clear()
                        showCreateAccPage();
                    }
                }
            }
        }
    }
}
