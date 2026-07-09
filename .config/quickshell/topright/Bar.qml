import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell
import "../widgets/"
import "../containers/"
import "../services/"

Scope {
  id: screenScope
  required property var modelData

  enum Section {
    Bluetooth,
    Conn,
    Clock
  }

  PanelWindow {
    id: rightWindow
    screen: modelData

    property bool targetExpanded: false
    property bool isExpanded: false

    anchors {
      top: true
      right: true
      left: true
    }

    margins {
      top: 0
      right: 0
      left: 0
    }

    exclusionMode: ExclusionMode.Normal
    aboveWindows: true

    implicitWidth:
      (!rightWindow.targetExpanded)
      ? rightCd.implicitWidth + 60 : 300
    implicitHeight: rightBg.height

    color: "transparent"

    mask: Region {
      item: rightBg
    }

    Item {
      anchors.fill: parent

      TopRightContainer {
        id: rightBg
        anchors.right: parent.right
        height:
          (!rightWindow.targetExpanded)
          ? 60 : 1200
        width:
          (!rightWindow.targetExpanded)
          ? rightCd.implicitWidth + 60 : 700

        Timer {
          id: runningTimer
          interval: 15
          repeat: true
          running: expandAnim.running

          onTriggered: {
            rightWindow.targetExpanded = rHover.hovered
          }
        }

        Behavior on height {
          NumberAnimation {
            duration: 350
            easing.type: Easing.OutExpo
          }
        }

        Behavior on width {
          NumberAnimation {
            id: expandAnim
            duration: 350
            easing.type: Easing.OutExpo

            onRunningChanged: {
              if (!running)
                rightWindow.isExpanded = rightWindow.targetExpanded
            }
          }
        }

        TopRightCollapsed {
          id: rightCd
          onRightCollapsedClicked: {
            rightWindow.targetExpanded = true
          }
        }

        TopRightExpanded {
          id: rightExp
        }
      }

      HoverHandler {
        id: rHover

        onHoveredChanged: {
          if (!hovered && rightWindow.isExpanded) {
            rightWindow.targetExpanded = false
          }
        }
      }
    }
  }
}
