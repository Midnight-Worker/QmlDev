import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    title: "SettingsPage"

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 12

        Label {
            text: "SettingsPage"
            font.pixelSize: 24
            Layout.alignment: Qt.AlignHCenter
        }

        Label {
            text: "Auch diese Seite kann live ersetzt werden."
            Layout.alignment: Qt.AlignHCenter
        }

        Button {
            text: "Zurück"
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                StackView.view.pop()
            }
        }
    }

}