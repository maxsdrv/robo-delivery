#include "Monitor.h"

using namespace robomonitor;


Monitor::Monitor(QObject* parent) : QObject(parent) {}

QString Monitor::timeInfo() const
{
    QDateTime currentDateTime = QDateTime::currentDateTime();
    QString date = currentDateTime.date().toString("yyyy-MM-dd");
    QString time = currentDateTime.time().toString("hh:mm:ss");

    return QString("Time: %1 Date: %2").arg(time, date);
}
