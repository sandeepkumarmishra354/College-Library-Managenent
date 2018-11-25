import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2

MessageDialog {
    id: dateDialog
    visible: false
    title: "Error"
    standardButtons: StandardButton.Ok
    text: qsTr("username or password incorrect")
    icon: StandardIcon.Critical
}
