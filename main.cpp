#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFileInfo>
#include <QDir>
#include <QObject>
#include <QString>
#include <QDebug>
#include <QDateTime>
#include <QUrl>
#include <QStandardPaths>

class LiveQmlController : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString liveDirPath READ liveDirPath CONSTANT)
    Q_PROPERTY(QString liveDirUrl READ liveDirUrl CONSTANT)

public:
    explicit LiveQmlController(QObject *parent = nullptr)
        : QObject(parent)
    {
        m_liveDirPath = detectLiveDir();
        m_liveDirUrl = QUrl::fromLocalFile(m_liveDirPath).toString();

        qDebug() << "Live QML directory path:" << m_liveDirPath;
        qDebug() << "Live QML directory url :" << m_liveDirUrl;
    }

    QString liveDirPath() const
    {
        return m_liveDirPath;
    }

    QString liveDirUrl() const
    {
        return m_liveDirUrl;
    }

    Q_INVOKABLE bool hasLiveFile(const QString &fileName) const
    {
        QFileInfo fileInfo(m_liveDirPath + "/" + fileName);
        return fileInfo.exists() && fileInfo.isFile();
    }

    Q_INVOKABLE QString pageUrl(const QString &pageName) const
    {
        QString fileName = pageName + ".qml";
        QString liveFilePath = m_liveDirPath + "/" + fileName;

        qDebug() << "Checking live file:" << liveFilePath;

        if (QFileInfo::exists(liveFilePath)) {
            QString liveUrl = QUrl::fromLocalFile(liveFilePath).toString();
            qDebug() << "Using LIVE file for" << pageName << ":" << liveUrl;
            return liveUrl;
        }

        QString fallback = QString("qrc:/qt/qml/QmlDev/%1").arg(fileName);
        qDebug() << "Using FALLBACK for" << pageName << ":" << fallback;
        return fallback;
    }

    Q_INVOKABLE QString pageUrlWithCacheBuster(const QString &pageName) const
    {
        QString baseUrl = pageUrl(pageName);
        QString cacheValue = QString::number(QDateTime::currentMSecsSinceEpoch());

        if (baseUrl.contains("?")) {
            return baseUrl + "&v=" + cacheValue;
        }

        return baseUrl + "?v=" + cacheValue;
    }

private:
    QString detectLiveDir() const
    {
        QString basePath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);

        if (basePath.isEmpty()) {
            basePath = QDir::currentPath();
        }

        QDir dir(basePath);
        dir.mkpath("liveqml");

        return dir.filePath("liveqml");
    }

private:
    QString m_liveDirPath;
    QString m_liveDirUrl;
};

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    LiveQmlController liveQml;
    engine.rootContext()->setContextProperty("liveQml", &liveQml);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() {
            QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection
        );

    engine.loadFromModule("QmlDev", "Main");

    return app.exec();
}

#include "main.moc"