import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0
import com.json.userdetails.db 1.0
import "../data-model"

Rectangle {
    id: details_root
    property var studentDetails: {"name":"","department":"","semester":"","phone":"","details":""}
    color: "#DAE0E2"
    StudentRecordData {id: srmodel}
    Component.onCompleted: {
        jsonuser_db.infoLoaded.connect(function(data){
            studentDetails = JSON.parse(data)
        })
    }

    Rectangle {
        id: container_rect
        anchors.centerIn: parent
        width: parent.width-parent.width/3
        height: parent.height-20
        color: "white"
        Column {
            id: main_column
            anchors.fill: parent
            Rectangle {
                id: info_rect
                width: container_rect.width
                height: container_rect.height/3.6
                Row {
                    id: info_row
                    anchors.fill: parent
                    Rectangle {
                        id: circle_rect
                        height: info_rect.height
                        width: height
                        Rectangle {
                            height: parent.height/1.5
                            width: height
                            radius: width/2
                            anchors.centerIn: parent
                            color: "#0A79DF"
                            Text {
                                text: (studentDetails.name === "")?"":studentDetails.name[0].toUpperCase()
                                anchors.centerIn: parent
                                color: "white"
                                font.bold: true
                                font.pointSize: parent.height/2
                            }
                        }
                    }
                    Rectangle {
                        id: sub_info_rect
                        height: info_rect.height
                        width: (info_rect.width-circle_rect.width)/1.5
                        InfoColumn {
                            id: info_column
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                    Rectangle {
                        id: status_rect
                        height: info_rect.height
                        width: (info_rect.width-circle_rect.width-sub_info_rect.width)
                        Column {
                            spacing: 5
                            anchors.centerIn: parent
                            Image {
                                id: status_img
                                source: rchk.checked?"qrc:/assets/status-returned.png":"qrc:/assets/status-not-returned.png"
                                width: status_rect.width/3
                                height: width
                                anchors.horizontalCenter: parent.horizontalCenter
                                mipmap: true
                                PropertyAnimation {
                                    id: anime
                                    target: status_img
                                    running: false
                                    properties: "scale,opacity"
                                    from:0;to:1
                                    easing.type: Easing.InOutQuad
                                    duration: 300
                                }
                                function startAnime() {
                                    anime.start()
                                }
                            }
                            CheckBox {
                                id: rchk
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: qsTr("returned")
                                checked: true
                                onCheckedChanged: {status_img.startAnime()}
                            }
                        }
                    }
                }
            }
            Rectangle {
                id: bookinfo_rect
                width: container_rect.width
                height: (container_rect.height-info_rect.height)-main_column.spacing
                border.color: "blue"
                BookTable {
                    id: book_table
                    width: parent.width
                    height: parent.height
                    sortIndicatorVisible: true
                    model: srmodel
                }
            }
        }
    }
}
