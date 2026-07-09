import QtQuick
import QtQuick.Layouts
import "../services/"

Item {
  id: control

  implicitWidth: 120
  implicitHeight: 40

  Layout.fillWidth: true
  Layout.preferredHeight: 40

  property string text: ""
  property bool isActive: false
  signal clicked()

  Rectangle {
    anchors.fill: parent
    radius: control.height / 2

    color: control.isActive ? Theme.buttonActive : Theme.buttonInactive
    Behavior on color {
      ColorAnimation {
        duration: 150
      }
    }

    Text {
      anchors.centerIn: parent
      text: control.text
      color: Theme.foreBright

      font {
        family: Theme.fontFam
        pointSize: 10
      }
    }
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: control.isActive ? Qt.ArrowCursor : Qt.PointingHandCursor
    onClicked: control.clicked()
  }
}
