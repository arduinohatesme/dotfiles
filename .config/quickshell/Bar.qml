import QtQuick
import Quickshell

Scope {
  id: root

  Variants {
    model: Quickshell.screens;

    PanelWindow {
      id: window

      required property var modelData
      readonly property color back: "#22172a"
      readonly property color foreBright: "#ffdfcf"
      readonly property color foreMid: "#a49990"
      readonly property color foreMuted: "#4e4940"
      readonly property string fontFam: "JetBrains Mono NF"
      readonly property int fontSizeSm: 12
      readonly property int fontSizeMed: 14
      readonly property int fontSizeLg: 18

      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 40
      color: window.back

      WorkspaceWidget {
        anchors.centerIn: parent
        id: workspaces
      }

      ClockWidget {
        anchors {
          left: workspaces.right
          leftMargin: 24
          verticalCenter: parent.verticalCenter
        }
        font {
          pixelSize: window.fontSizeMed
          family: window.fontFam
        }
        color: window.foreBright
      }

      ConnWidget {
        anchors {
          right: workspaces.left
          rightMargin: 24
          verticalCenter: parent.verticalCenter
        }
      }
    }
  }
}
