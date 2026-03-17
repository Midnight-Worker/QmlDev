import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: window
    width: 400
    height: 800
    visible: true
    title: "QmlDev"

    function pushPage(pageName) {
        let url = liveQml.pageUrlWithCacheBuster(pageName)
        console.log("pushPage:", pageName, url)
        stack.push(url)
    }

    function resetToPage(pageName) {
        let url = liveQml.pageUrlWithCacheBuster(pageName)
        console.log("resetToPage:", pageName, url)
        stack.clear()
        stack.push(url)
    }

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 8
            anchors.rightMargin: 8
            spacing: 8

            Button {
                text: "Main"
                onClicked: window.resetToPage("MainPage")
            }

            Button {
                text: "Settings"
                onClicked: window.pushPage("SettingsPage")
            }

            Button {
                text: "Reload"
                onClicked: window.resetToPage("MainPage")
            }

            Item {
                Layout.fillWidth: true
            }

            Label {
                text: liveQml.liveDirPath
                elide: Text.ElideMiddle
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignRight
            }
        }
    }

    StackView {
        id: stack
        anchors.fill: parent
    }

    Component.onCompleted: {
        window.resetToPage("MainPage")
    }
}