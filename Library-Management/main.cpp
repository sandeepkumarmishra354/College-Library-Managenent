#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "db-api/databaseapi.h"
#include "db-api/userdetailsapi.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    //QQuickStyle::setStyle("Material");
    qmlRegisterType<DatabaseApi>("com.json.db",1,0,"JsonDb");
    qmlRegisterType<UserDetailsApi>("com.json.userdetails.db",1,0,"UserDetailsDb");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
