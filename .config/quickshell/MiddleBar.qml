import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell
import "./widgets/"
import "./services/"
import "./containers/"

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

    TopMiddleContainer {
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
