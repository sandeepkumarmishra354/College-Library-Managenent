import QtQuick 2.9
import QtQuick.Controls 2.3

ListModel {
    id: model_root
    Component.onCompleted: {
        jsonuser_db.bookDataLoaded.connect(function(data){
            var json_data = JSON.parse(data)
            var date = json_data.date
            var books = json_data.books
            if(model_root !== null)
            {
                clear()
                for(var i in books)
                {
                    append({"bookName":books[i],"issueDate":date})
                }
            }
        })
    }
}
