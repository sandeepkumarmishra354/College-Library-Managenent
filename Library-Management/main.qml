import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.3
import com.json.db 1.0
import com.json.userdetails.db 1.0
import "custom-component"
import "pages"
import "JS/logic.js" as LG

ApplicationWindow {
    id: application_root
    visible: true
    title: qsTr("PSRIET Library Management")
    height: Screen.height
    width: Screen.width
    minimumWidth: 640
    minimumHeight: 480
    background: Image {
        id: bg_image
        source: "qrc:/assets/clg1.jpg"
        mipmap: true
    }

    UserDetailsDb {
        id: json_userdetails_db
    }
    JsonDb {id: json_db}
    StackView {
        id: view
        anchors.fill: parent
        initialItem: HomePage{}
    }
}
