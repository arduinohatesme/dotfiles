import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell

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
