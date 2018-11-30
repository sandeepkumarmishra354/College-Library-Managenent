import QtQuick 2.9
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import com.json.db 1.0
import com.json.userdetails.db 1.0
import "../custom-component"

Page {
    id: page_root
    background: Rectangle {
        id: bg_image
        color: "#00000000"
    }
    UserDetailsDb {id: json_userdetails_db}
    JsonDb {id: json_db}
    SwipeView {
        id: view
        anchors.fill: parent
        LoginPage {
            increment: function() {
                view.currentIndex = 1;
            }
            mainStack: page_root.parent
            jsondb: json_db
            jsonuser_db: json_userdetails_db
        }
        CreateAccount {
            id: ca_page
            jsondb: json_db
            jsonuser_db: json_userdetails_db
            mainStack: page_root.parent
            decrement: function() {
                view.currentIndex = 0;
            }
        }
    }
    PageIndicator {
        id: pageIndicator
        interactive: true
        count: view.count
        currentIndex: view.currentIndex
        delegate: Rectangle {
            implicitHeight: 10
            implicitWidth: 10
            radius: width/2
            color: "#E71C23"
            opacity: index === pageIndicator.currentIndex ? 1.0 : 0.45
            Behavior on opacity {
                OpacityAnimator {
                    duration: 400
                }
            }
        }

        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
