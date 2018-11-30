import QtQuick 2.9
import QtQuick.Controls 2.3

Column {
    id: info_column
    spacing: 5
    Row {
        spacing: 5
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            text: qsTr("Name")
            color: "#0A3D62"
        }
        Text {
            text: qsTr(studentDetails.name)
            color: "#0A79DF"
        }
    }
    Row {
        spacing: 5
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            text: qsTr("Department:")
            color: "#0A3D62"
        }
        Text {
            text: qsTr(studentDetails.department)
            color: "#0A79DF"
        }
    }
    Row {
        spacing: 5
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            text: qsTr("Semester:")
            color: "#0A3D62"
        }
        Text {
            text: qsTr(studentDetails.semester)
            color: "#0A79DF"
        }
    }
    Row {
        spacing: 5
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            text: qsTr("Phone:")
            color: "#0A3D62"
        }
        Text {
            text: qsTr(studentDetails.phone)
            color: "#0A79DF"
        }
    }
    Row {
        spacing: 5
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            text: qsTr("details:")
            color: "#0A3D62"
        }
        Text {
            text: qsTr(studentDetails.details)
            color: "#0A79DF"
        }
    }
}
