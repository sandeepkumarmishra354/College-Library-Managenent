#include "userdetailsapi.h"
#include <QStandardPaths>

UserDetailsApi::UserDetailsApi(QObject *parent) : QObject(parent)
{
    db_file = getDatabasePath() + "plbmusrdb.dat";
    connect(&pThread,&QThread::started,this, &UserDetailsApi::initNameList);
    connect(this,&UserDetailsApi::threadFinished,&pThread,&QThread::quit);
}

void UserDetailsApi::initNameList()
{
    qDebug()<<"Thread started";
    QString jcontent = getFileContent();
    if(!jcontent.isEmpty())
    {
        QJsonParseError jerror;
        QJsonDocument rdoc = QJsonDocument::fromJson(jcontent.toUtf8(),&jerror);
        if(jerror.error == QJsonParseError::NoError)
        {
            QJsonObject root_obj = rdoc.object();
            if(root_obj.contains(loggedInUser))
            {
                QJsonObject user_obj = root_obj[loggedInUser].toObject();
                QJsonArray sidarr = user_obj["users_id"].toArray();
                foreach(auto itm, sidarr)
                {
                    QString sid = itm.toString();
                    QJsonObject tmp_obj = user_obj[sid].toObject();
                    emitAddedSignal(tmp_obj);
                    qDebug()<<"signal emitted: "<<sid;
                }
            }
        }
        else
            qDebug()<<"JSON Parse Error";
    }
    emit threadFinished();
    threadRunning = false;
    qDebug()<<"Thread ended";
}

QString UserDetailsApi::getDatabasePath()
{
    QString path = QStandardPaths::locate(QStandardPaths::AppDataLocation,QString(),QStandardPaths::LocateDirectory);
    return path;
}

void UserDetailsApi::writeToFile(const QString &content)
{
    QFile file(db_file);
    if(file.open(QIODevice::WriteOnly))
    {
        QDataStream out(&file);
        out << content;
        file.close();
    }
}

QString UserDetailsApi::getFileContent() const
{
    QString content = "";
    QFile file(db_file);
    if(file.open(QIODevice::ReadOnly))
    {
        QDataStream in(&file);
        in >> content;
        file.close();
    }
    return content;
}

bool UserDetailsApi::login(const QString &user)
{
    if(user.isEmpty())
    {
        loggedInUser = "";
        LoggedIn = false;
        qDebug()<<"User is empty can't login...";
    }
    else
    {
        loggedInUser = user;
        LoggedIn = true;
        qDebug()<<"New Logged in user: "<<user;
    }
    return LoggedIn;
}

bool UserDetailsApi::logout(const QString &user)
{
    bool status;
    if(loggedInUser == user)
    {
        loggedInUser = "";
        LoggedIn = false;
        status = true;
        qDebug()<<"User logged out: "<<user;
    }
    else
    {
        status = false;
        qDebug()<<"unable to logout,loggedin: "<<loggedInUser<<"logout as: "<<user;
    }

    return status;
}

bool UserDetailsApi::addNewRecord(const QString &data)
{
    qDebug()<<data;
    //add new student record to database
    bool status = false;
    QString jcontent = getFileContent();
    if(jcontent.isEmpty())
    {
        //means there is no record saved yet
        QJsonParseError jerror;
        QJsonDocument udoc = QJsonDocument::fromJson(data.toUtf8(),&jerror);
        if(jerror.error == QJsonParseError::NoError)
        {
            QJsonObject newRecObj = udoc.object();
            QJsonObject rootObj;
            QString sid = QString::number(newRecObj["sid"].toInt());
            qDebug()<<"NEW SID: "<<sid;
            QJsonArray sidarr;
            QJsonObject recObj;
            sidarr.append(QJsonValue(sid));
            recObj[sid] = QJsonValue(newRecObj);
            recObj["users_id"] = sidarr;
            rootObj[loggedInUser] = recObj;
            QString json_con = QJsonDocument(rootObj).toJson(QJsonDocument::Indented);
            //qDebug()<<json_con;
            writeToFile(json_con);
            emitAddedSignal(newRecObj);
            status = true;
        }
        else
            status = false;
    }
    else
    {
        //means there is already some records are saved
        QJsonParseError jerror1,jerror2;
        QJsonDocument newDoc = QJsonDocument::fromJson(data.toUtf8(),&jerror1);
        QJsonDocument rootDoc = QJsonDocument::fromJson(jcontent.toUtf8(),&jerror2);
        if(jerror1.error == QJsonParseError::NoError && jerror2.error == QJsonParseError::NoError)
        {
            QJsonObject newRecObj = newDoc.object();
            QJsonObject rootObj = rootDoc.object();

            if(rootObj.contains(loggedInUser))
                appendRecord(newRecObj,rootObj);
            else
            {
                createNewRecord(newRecObj,rootObj);
            }

            status = true;
        }
        else
            status = false;
    }

    return status;
}

void UserDetailsApi::createNewRecord(QJsonObject newRecObj, QJsonObject rootObj)
{
    QString sid = QString::number(newRecObj["sid"].toInt());
    qDebug()<<"NEW SID: "<<sid;
    QJsonArray sidarr;
    QJsonObject recObj;
    sidarr.append(QJsonValue(sid));
    recObj[sid] = newRecObj;
    recObj["users_id"] = sidarr;
    rootObj[loggedInUser] = recObj;
    QString json_con = QJsonDocument(rootObj).toJson(QJsonDocument::Indented);
    writeToFile(json_con);
    emitAddedSignal(newRecObj);
}

void UserDetailsApi::appendRecord(QJsonObject newRecObj, QJsonObject rootObj)
{
    QString sid = QString::number(newRecObj["sid"].toInt());
    QJsonObject recObj = rootObj[loggedInUser].toObject();
    QJsonArray sidarr = recObj["users_id"].toArray();
    sidarr.append(sid);
    recObj["users_id"] = sidarr;
    recObj[sid] = QJsonValue(newRecObj);
    rootObj[loggedInUser] = recObj;
    QString json_con = QJsonDocument(rootObj).toJson(QJsonDocument::Indented);
    writeToFile(json_con);
    emitAddedSignal(newRecObj);
}

void UserDetailsApi::emitAddedSignal(const QJsonObject &newRecObj)
{
    QString sid = QString::number(newRecObj["sid"].toInt());
    QJsonObject tmp_obj;
    tmp_obj["name"] = newRecObj["name"].toString();
    tmp_obj["department"] = newRecObj["department"].toString();
    tmp_obj["sid"] = sid;
    QString dataToSend = QJsonDocument(tmp_obj).toJson();
    emit newRecordAdded(dataToSend);
}

bool UserDetailsApi::updateRecord(const QString &newData)
{
    //update student details
    qDebug()<<newData;
    return true;
}

void UserDetailsApi::nameListInitiated()
{
    pThread.start();
    threadRunning = true;
    qDebug()<<"Name List Initiated";
}

void UserDetailsApi::loadBookData(const QString &sid)
{
    currentStudentId = sid;
    QString jcontent = getFileContent();
    if(!jcontent.isEmpty())
    {
        QJsonParseError jerror;
        QJsonDocument rdoc = QJsonDocument::fromJson(jcontent.toUtf8(),&jerror);
        if(jerror.error == QJsonParseError::NoError)
        {
            QJsonObject root_obj = rdoc.object();
            if(root_obj.contains(loggedInUser))
            {
                QJsonObject user_obj = root_obj[loggedInUser].toObject();
                QJsonObject tmp_obj = user_obj[sid].toObject();
                QJsonObject s_obj;
                QJsonObject i_obj;

                s_obj["books"] = tmp_obj["books"].toArray();
                s_obj["date"] = tmp_obj["date"].toString();

                i_obj["name"] = tmp_obj["name"].toString();
                i_obj["department"] = tmp_obj["department"].toString();
                i_obj["semester"] = tmp_obj["semester"].toString();
                i_obj["phone"] = tmp_obj["phone"].toString();
                i_obj["details"] = tmp_obj["details"].toString();

                QString jcon = QJsonDocument(s_obj).toJson();
                QString jicon = QJsonDocument(i_obj).toJson();

                emit bookDataLoaded(jcon);
                emit infoLoaded(jicon);
            }
        }
        else
            qDebug()<<"JSON Parse Error";
    }
}

UserDetailsApi::~UserDetailsApi()
{
    if(threadRunning)
        emit threadFinished();
}
