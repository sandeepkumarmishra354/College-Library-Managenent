import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import "../JS/logic.js" as LOGIC

Popup {
    property string s_name: ""
    property string s_department: ""
    property string s_details: ""
    property string s_semester: ""
    property string s_phone: ""
    property variant s_issued_books: []
    property bool isDataSaving: false
    id: popup_root
    width: 450
    height: 300
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape
    ErrorDialog{id:dialog}

    BusyIndicator {
        id: busyInd
        running: isDataSaving
        anchors.centerIn: parent
        z: -1
    }
    enter: Transition {
        NumberAnimation {
            property: "opacity"
            from: 0.0; to: 1.0
            //duration: 700
        }
    }
    exit: Transition {
        NumberAnimation {
            property: "opacity"
            from: 1.0; to: 0.0
        }
    }
    Rectangle {
        id: main_rect_con
        anchors.fill: parent
        Rectangle {
            id: d_header
            width: main_rect_con.width
            height: 40
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            color: "#0A79DF"
            Text {
                text: qsTr("Add New Record")
                color: "white"
                font.bold: true
                font.pointSize: 15
                anchors.centerIn: parent
            }
        }

        Column {
            width: parent.width
            height: parent.height-50
            anchors.top: d_header.bottom
            topPadding: 15
            spacing: 5
            Row {
                spacing: 5
                anchors.horizontalCenter: parent.horizontalCenter
                TextField {
                    text: s_name
                    placeholderText: qsTr("Student name")
                    onTextChanged: {s_name = text}
                    enabled: !isDataSaving
                    font.capitalization: Font.AllLowercase
                }
                TextField {
                    text: s_department
                    placeholderText: qsTr("Department")
                    onTextChanged: {s_department = text}
                    enabled: !isDataSaving
                    font.capitalization: Font.AllUppercase
                }
            }
            Row {
                spacing: 5
                anchors.horizontalCenter: parent.horizontalCenter
                TextField {
                    text: s_semester
                    placeholderText: qsTr("Semester(optional)")
                    onTextChanged: {s_semester = text}
                    enabled: !isDataSaving
                    font.capitalization: Font.AllLowercase
                }
                TextField {
                    text: s_phone
                    placeholderText: qsTr("Phone No.")
                    onTextChanged: {s_phone = text}
                    enabled: !isDataSaving
                    maximumLength: 10
                    validator: RegExpValidator {
                        regExp: /^[0-9]+$/ /*only digits allowed */
                    }
                }
            }
            Row {
                spacing: 5
                anchors.horizontalCenter: parent.horizontalCenter
                TextField {
                    placeholderText: qsTr("Issued books")
                    ToolTip.visible: hovered
                    ToolTip.timeout: 3000
                    enabled: !isDataSaving
                    font.capitalization: Font.AllLowercase
                    ToolTip.text: qsTr("if there are more than one book then\nseperate them with semi-colon(;)")
                    onTextChanged: {
                        if(text !== "")
                            s_issued_books = text.split(";")
                        else
                            s_issued_books = []
                    }
                }
                TextField {
                    text: s_details
                    placeholderText: qsTr("more details(optional)")
                    onTextChanged: {s_details = text}
                    enabled: !isDataSaving
                    font.capitalization: Font.AllLowercase
                }
            }
        }

        Rectangle {
            height: 40
            width: parent.width
            anchors.bottom: parent.bottom
            anchors.left:parent.left
            anchors.right:parent.right
            Row {
                spacing: 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 5
                MyButton {
                    text: qsTr("Cancel")
                    onClicked: {
                        popup_root.close()
                    }
                    enabled: !isDataSaving
                }
                MyButton {
                    text: qsTr("Submit")
                    buttonColor: "#0A79DF"
                    pressedColor: "#4834DF"
                    enabled: !isDataSaving
                    onClicked: {
                        if(s_name !== "" && s_department !== "" && s_issued_books.length > 0 && s_phone !== "")
                        {
                            busyInd.z = 3
                            isDataSaving = true
                            s_semester = (s_semester === "")?"NA":s_semester
                            s_details = (s_details === "")?"NA":s_details
                            var phonetxt = "+91"+s_phone
                            var sid = LOGIC.getRandomNum()
                            var date = new Date().toDateString()
                            var data = {name:s_name,department:s_department,phone:phonetxt,books:s_issued_books,
                            details:s_details,semester:s_semester,sid:sid,date:date}
                            var s_data = JSON.stringify(data)
                            jsonuser_db.addNewRecord(s_data)
                            busyInd.z = -1
                            isDataSaving = false
                            popup_root.close()
                        }
                        else
                        {
                            dialog.text = qsTr("Can't submit the record. Some fields are mendotary")
                            dialog.open()
                        }
                    }
                }
            }
        }
    }
    onClosed: {
        s_name = ""
        s_department = ""
        s_details = ""
        s_issued_books = ""
        s_phone = ""
        s_semester = ""
    }
}
