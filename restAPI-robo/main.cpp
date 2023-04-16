#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>

#include "Monitor.h"

using namespace robomonitor;

int main(int argc, char** argv) {
  
  QGuiApplication app(argc, argv);  

  QQmlApplicationEngine engine;
  const QUrl url(QStringLiteral("qrc:/Viewer.qml"));
  QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &app, 
      [url](QObject* obj, const QUrl& objUrl) {
          if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
      }, Qt::QueuedConnection);

  Monitor monitor;
  engine.rootContext()->setContextProperty("monitor", &monitor);

  engine.load(url);

  return QGuiApplication::exec();

}
