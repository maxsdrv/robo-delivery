#pragma once

#include <QObject>
#include <QDateTime>


namespace robomonitor {

/* class for interaction with server and qml interface */

class Monitor : public QObject {
  Q_OBJECT
    Q_PROPERTY(QString timeInfo READ timeInfo NOTIFY timeInfoChanged)
public:
  explicit Monitor(QObject* parent = nullptr);

    QString timeInfo() const;
private:

public slots:

signals:
    void timeInfoChanged();
};


}; //end namespace robomonitor
