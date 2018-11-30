import QtQuick 2.9
import QtQuick.Controls 2.3
import com.json.userdetails.db 1.0
import com.json.db 1.0
import "../data-model"

ListView {
    id: list_root
    property var userClicked: null
    property int c_index: 0
    property UserDetailsDb json_userdb: null
    StudentNameData {
        id:s_data_model
        jsonuser_db: json_userdb
    }
    Component {
        id: headerComponent
        Rectangle {
            z:4
            width: list_root.width
            height: 40
            color: "#0A79DF"
            Text {
                text: qsTr("Students Name")
                anchors.centerIn: parent
                color: "white"
            }
        }
    }
    model: s_data_model
    delegate: Component {
        StudentNameDelegate {
            normalColor: (index === currentIndex)?"#1A000000":"white"
            hoveredColor: "#1A000000"
            textColor: "#0A79DF"
            studentName: name
            sid: stid
            studentDepartment: department
            onClicked: {
                currentIndex = index
                jsonuser_db.loadBookData(sid)
            }
        }
    }

    header: headerComponent
    spacing: 8
    snapMode: ListView.SnapToItem
    clip: true
    focus: true
    headerPositioning: ListView.OverlayHeader
    ScrollBar.vertical: ScrollBar{ id: nameListScrollbar }
}
