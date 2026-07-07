import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell

Scope {
  id: window

  Variants {
    model: Quickshell.screens;

    PanelWindow {
      id: middleWindow
      screen: middleWindow.modelData
      anchors {
        top: true
      }

      required property var modelData

      margins {
        left: 0
        right: 0
        top: 0
      }

      exclusionMode: ExclusionMode.Normal
      aboveWindows: true

      implicitWidth: middleLayout.implicitWidth + 44 + height
      implicitHeight: 40
      color: "transparent"

      mask: Region {
        item: middleBg
      }

      MiddleBackground {
        id: middleBg
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
      }

      RowLayout {
        id: middleLayout
        implicitHeight: parent.height
        anchors.centerIn: parent
        spacing: 24

        Item {
          implicitHeight: parent.height
          implicitWidth: childrenRect.width
          WorkspaceWidget {
            id: workspaces
            anchors.verticalCenter: parent.verticalCenter
          }
        }
      }
    }
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: rightWindow
      screen: rightWindow.modelData
      anchors {
        top: true
        right: true
      }

      required property var modelData

      margins {
        left: 0
        right: 0
        top: 0
      }

      exclusionMode: ExclusionMode.Normal
      aboveWindows: true

      implicitWidth: rightLayout.implicitWidth + 22 + height
      implicitHeight: 60
      color: "transparent"

      mask: Region {
        item: rightBg
      }

      RightBackground {
        id: rightBg
        width: rightLayout.implicitWidth
      }

      RowLayout {
        id: rightLayout
        implicitHeight: 40
        anchors {
          top: parent.top
          right: parent.right
          rightMargin: 33
        }
        spacing: 24

        Item {
          implicitHeight: parent.height
          implicitWidth: childrenRect.width
          BluetoothWidget {
            anchors {
              verticalCenter: parent.verticalCenter
            }
          }
        }

        Item {
          implicitHeight: parent.height
          implicitWidth: childrenRect.width
          ConnWidget {
            id: conns
            anchors {
              verticalCenter: parent.verticalCenter
            }
          }
        }

        Item {
          implicitHeight: parent.height
          implicitWidth: childrenRect.width
          ClockWidget {
            anchors {
              verticalCenter: parent.verticalCenter
            }
            font {
              pixelSize: Theme.fontSizeMed
              family: Theme.fontFam
            }
            color: Theme.foreBright
          }
        }
      }


    }
  }
}
