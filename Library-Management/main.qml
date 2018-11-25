import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.3
import "custom-component"
import "pages"
import com.json.db 1.0

ApplicationWindow {
    id: root
    visible: true
    title: qsTr("PSRIET Library Management")
    width: 1366
    height: 768

    LoggedInPage{id:l_page}
    JsonDb {id: json_db}
    StackView {
        id: stack_view
        property string name: "sandeep"
        anchors.fill: parent
        CreateAccount {
            id: ca_page
            jsondb: json_db
        }
        initialItem: LoginPage{
            showCreateAccPage: function() {
                stack_view.push(ca_page);
            }
            jsondb: json_db
        }
    }
}
