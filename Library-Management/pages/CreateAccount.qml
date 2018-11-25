import QtQuick 2.9
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import "../custom-component"
import com.json.db 1.0

Page {
    id: page_root
    property JsonDb jsondb: null
    property bool isCreating: false
    background: Image {
        id: bg_image
        source: "qrc:/assets/signup-bg.jpg"
        MyButton {
            text: qsTr("Go back")
            buttonColor: "#BB2CD9"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 5
            anchors.topMargin: 5
            onClicked: page_root.parent.pop()
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
                onClicked: {
                    if(page_rect.password_txt.length <6 || page_rect.username_txt == "")
                    {
                        dialog.text = qsTr("password must be 6 character long.\n"+
                                            "And username can't be empty")
                        dialog.visible = true
                        return;
                    }
                    else
                    {
                        var st = jsondb.isUsernameAvailable(page_rect.username_txt)
                        if(st)
                        {
                            enabled = false
                            jsondb.saveNewUsernamePassword(page_rect.username_txt,
                                                           page_rect.password_txt)
                            enabled = true
                        }
                        else
                        {
                            dialog.text = qsTr("username already exists try diff. username")
                            dialog.visible = true
                        }
                    }
                }
            }
            MyButton {
                text: "Login"
                anchors.horizontalCenter: parent.horizontalCenter
                buttonColor: "#AE1438"
                pressedColor: "#E71C23"
                onClicked: {
                    username_id.clear()
                    password_id.clear()
                    page_root.parent.pop()
                }
            }
        }
    }
}
