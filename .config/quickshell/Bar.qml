import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
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
      }

      margins {
        left: 0
        right: 0
        top: 0
      }

      implicitWidth: middleLayout.implicitWidth + 44 + height
      implicitHeight: 40
      color: "transparent"

      mask: Region {
        item: middleBg
      }

      MiddleBackground {
        id: middleBg
      }

      RowLayout {
        id: middleLayout
        height: parent.height
        anchors.centerIn: parent
        spacing: 24

        Item {
          height: parent.height
          width: childrenRect.width
          BluetoothWidget {
            anchors {
              verticalCenter: parent.verticalCenter
            }
          }
        }

        Item {
          height: parent.height
          width: childrenRect.width
          ConnWidget {
            id: conns
            anchors {
              verticalCenter: parent.verticalCenter
            }
          }
        }

        Item {
          height: parent.height
          width: childrenRect.width
          WorkspaceWidget {
            id: workspaces
            anchors.verticalCenter: parent.verticalCenter
          }
        }

        Item {
          height: parent.height
          width: childrenRect.width
          ClockWidget {
            anchors {
              verticalCenter: parent.verticalCenter
            }
            font {
              pixelSize: window.fontSizeMed
              family: window.fontFam
            }
            color: window.foreBright
          }
        }
      }
    }
  }
}
