#include "databaseapi.h"
#include <QStandardPaths>

DatabaseApi::DatabaseApi(QObject *parent) : QObject(parent)
{
    db_file = getDatabasePath() + "plbmdb.dat";
}

void DatabaseApi::writeToFile(const QString &content)
{
    QFile file(db_file);
    if(file.open(QIODevice::WriteOnly))
    {
        QDataStream out(&file);
        out << content;
        file.close();
    }
}

QString DatabaseApi::getFileContent() const
{
    QString content = "";
    QFile file(db_file);
    if(file.open(QIODevice::ReadOnly))
    {
        QDataStream in(&file);
        in >> content;
        qDebug()<<content;
        file.close();
    }
    return content;
}

QString DatabaseApi::getDatabasePath()
{
    QString path = QStandardPaths::locate(QStandardPaths::AppDataLocation,QString(),QStandardPaths::LocateDirectory);
    return path;
}

bool DatabaseApi::saveNewUsernamePassword(const QString &usrnm, const QString &pswrd)
{
    bool status = false;
    QJsonParseError jerror;
    QString file_con = getFileContent();
    if(file_con.isEmpty())
    {
        QJsonObject jobj;
        QJsonArray jArr;
        QJsonArray t_jarr;
        t_jarr.append(QJsonValue(usrnm));
        t_jarr.append(QJsonValue(pswrd));
        jArr.append(QJsonValue(t_jarr));
        jobj["users"] = jArr;
        QString json_con = QJsonDocument(jobj).toJson(QJsonDocument::Indented);
        writeToFile(json_con);
        status = true;
    }
    else
    {
        QJsonDocument jdoc = QJsonDocument::fromJson(file_con.toUtf8(),&jerror);
        if(jerror.error == QJsonParseError::NoError)
        {
            jsonObj = jdoc.object();
            QJsonArray jArr = jsonObj["users"].toArray();
            QJsonArray t_jarr;
            t_jarr.append(QJsonValue(usrnm));
            t_jarr.append(QJsonValue(pswrd));
            jArr.append(QJsonValue(t_jarr));
            jsonObj["users"] = jArr;
            QString json_con = QJsonDocument(jsonObj).toJson(QJsonDocument::Indented);
            writeToFile(json_con);
            status = true;
        }
        else
            status = false;
    }
    return status;
}

bool DatabaseApi::isCorrect(const QString &usrnm, const QString &pswrd)
{
    qDebug()<<usrnm<<" "<<pswrd;
    QString file_con = getFileContent();
    if(file_con.isEmpty())
        return false;
    else
    {
        QJsonParseError jerror;
        QJsonDocument jdoc = QJsonDocument::fromJson(file_con.toUtf8(),&jerror);
        jsonObj = jdoc.object();
        if(jerror.error == QJsonParseError::NoError)
        {
            QJsonArray jArr = jsonObj["users"].toArray();
            foreach(auto itm, jArr)
            {
                itm = itm.toArray();
                if(itm[0].toString() == usrnm && itm[1].toString() == pswrd)
                    return true;
            }
        }
    }
    return false;
}

bool DatabaseApi::isUsernameAvailable(const QString &usrnm)
{
    QString file_con = getFileContent();
    if(!file_con.isEmpty())
    {
        QJsonParseError jerror;
        QJsonDocument jdoc = QJsonDocument::fromJson(file_con.toUtf8(),&jerror);
        jsonObj = jdoc.object();
        if(jerror.error == QJsonParseError::NoError)
        {
            QJsonArray jArr = jsonObj["users"].toArray();
            foreach(auto itm, jArr)
            {
                itm = itm.toArray();
                if(itm[0].toString() == usrnm)
                {
                    return false;
                }
            }
        }
    }

    return true;
}

DatabaseApi::~DatabaseApi()
{
    //
}
