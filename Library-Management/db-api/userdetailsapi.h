#ifndef USERDETAILSAPI_H
#define USERDETAILSAPI_H
#include <QObject>
#include <QString>
#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonParseError>
#include <QJsonValue>
#include <QFile>
#include <QIODevice>
#include <QDataStream>
#include <QThread>

class UserDetailsApi : public QObject
{
    Q_OBJECT
private:
    QString db_file;
    QString loggedInUser;
    QString currentStudentId;
    QThread pThread;
    bool LoggedIn = false;
    bool threadRunning = false;
    void writeToFile(QString const&);
    QString getFileContent() const;
    void appendRecord(QJsonObject,QJsonObject);
    void createNewRecord(QJsonObject,QJsonObject);
    void emitAddedSignal(QJsonObject const&);
private slots:
    void initNameList();
public:
    UserDetailsApi(QObject *parent=nullptr);
    ~UserDetailsApi();
    Q_INVOKABLE static QString getDatabasePath();
    Q_INVOKABLE bool login(QString const&);
    Q_INVOKABLE bool isLoggedIn()const {return LoggedIn;}
    Q_INVOKABLE bool logout(QString const&);
    Q_INVOKABLE QString getLoggedInUser()const {return loggedInUser;}
    Q_INVOKABLE bool addNewRecord(QString const&);
    Q_INVOKABLE bool updateRecord(QString const&);
    Q_INVOKABLE void nameListInitiated();
    Q_INVOKABLE void loadBookData(QString const&);
signals:
    void newRecordAdded(QString const&);
    void threadFinished();
    void bookDataLoaded(QString const&);
    void infoLoaded(QString const&);
};

#endif // USERDETAILSAPI_H
