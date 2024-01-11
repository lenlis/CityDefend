import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: mainPage
    objectName: "mainPage"
    allowedOrientations: Orientation.All

    Image {
        id: menuBack
        source: "../icons/menuBack.png"
        height: parent.height
        width: parent.width
        fillMode: Image.Stretch
    }
    Column{
        spacing: 100
        width: parent.width - 200
        anchors.left: parent.left
        anchors.leftMargin: 100
        anchors.top: parent.top
        anchors.topMargin: 300
        Button{
            width: parent.width
            height: 100
            Rectangle{
                radius: 6
                height: parent.height-8
                width: parent.width
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 4
                color: "#C0FFFFFF"
                Text {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: parent.width/2 - this.width/2
                    anchors.topMargin: parent.height/2 - this.height/2
                    text: qsTr("Начать игру")
                }
            }

            onClicked: pageStack.push("GamePage.qml")

        }
        Button{
            width: parent.width
            height: 100
            Rectangle{
                radius: 6
                height: parent.height-8
                width: parent.width
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 4
                color: "#C0FFFFFF"
                Text {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: parent.width/2 - this.width/2
                    anchors.topMargin: parent.height/2 - this.height/2
                    text: qsTr("Правила")
                }
            }
            onClicked: pageStack.push("AboutPage.qml")
        }
    }
}
