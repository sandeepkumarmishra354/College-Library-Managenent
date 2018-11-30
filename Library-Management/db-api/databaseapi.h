#ifndef DATABASEAPI_H
#define DATABASEAPI_H
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

class DatabaseApi : public QObject
{
    Q_OBJECT
private:
    QString db_file;
    const QString db_file_name = "admins-record.dat";
    QJsonObject jsonObj;
    void writeToFile(QString const&);
    QString getFileContent() const;
public:
    explicit DatabaseApi(QObject *parent=nullptr);
    ~DatabaseApi();
    Q_INVOKABLE static QString getDatabasePath();
    Q_INVOKABLE bool saveNewUsernamePassword(QString const&,QString const&);
    Q_INVOKABLE bool isCorrect(QString const&,QString const&);
    Q_INVOKABLE bool isUsernameAvailable(QString const&);
};

#endif // DATABASEAPI_H
