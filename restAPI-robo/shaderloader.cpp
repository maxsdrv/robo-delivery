#include <QDebug>

#include "shaderloader.h"

ShaderLoader::ShaderLoader(QObject* parent) : QObject(parent)
{

}

QString ShaderLoader::loadShader(const QString& filePath) {
    QFile file(filePath);

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Cannot open shader file:" << filePath;
        return QString();
    }

    QTextStream in(&file);
    QString content = in.readAll();
    file.close();
    return content;
}
