#ifndef SHADERLOADER_H
#define SHADERLOADER_H

#include <QObject>
#include <QFile>

class ShaderLoader : public QObject
{
    Q_OBJECT
public:
    explicit ShaderLoader(QObject* parent = nullptr);

    Q_INVOKABLE QString loadShader(const QString& filePath);
};

#endif // SHADERLOADER_H
