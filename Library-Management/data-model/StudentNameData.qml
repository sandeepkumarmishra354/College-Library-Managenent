import QtQuick 2.9
import QtQuick.Controls 2.3

ListModel {
    id: model_root
    property UserDetailsDb jsonuser_db: null
    Component.onCompleted: {
        jsonuser_db.newRecordAdded.connect(function(data) {
            var jdata = JSON.parse(data)
            if(model_root !== null)
                append({"name":jdata.name,"department":jdata.department,"stid":jdata.sid})
        })
        jsonuser_db.nameListInitiated()
    }
}
