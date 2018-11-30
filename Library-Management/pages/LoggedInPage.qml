import QtQuick 2.9
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import com.json.userdetails.db 1.0
import "../custom-component"
import "../JS/logic.js" as LOGIC

Item {
    id: root
    property string current_user: ""
    property StackView mainStack: null
    property UserDetailsDb jsonuser_db: null

    Rectangle {
        id: main_rect
        anchors.fill: parent
        Header {id:r_header;anchors.top: parent.top;judb: jsonuser_db}
        DropShadow {
            anchors.fill: r_header
            horizontalOffset: 3
            verticalOffset: 3
            radius: 8.0
            color: "#80000000"
            source: r_header
        }
        Rectangle {
            id: list_rect
            width: 200
            height: parent.height - r_header.height
            anchors.left: parent.left
            anchors.top: r_header.bottom

            StudentsName {
                id: sn_list
                json_userdb: jsonuser_db
                anchors.fill: parent
                userClicked: function userClicked(user) {
                    current_user = user
                }
            }
        }
        StudentDetailsSection {
            id: details_rect
            anchors.top: r_header.bottom
            anchors.bottom: user_options_rect.top
            anchors.left: list_rect.right
            anchors.right: parent.right
        }

        StudentOptionSection {
            id: user_options_rect
            width: details_rect.width
            anchors.bottom: parent.bottom
            anchors.left: list_rect.right
            anchors.right: parent.right
        }
    }
}
