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

    property int activeMenu: RightSection.ActiveMenu.Collapsed

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
      (activeMenu === RightSection.ActiveMenu.Collapsed)
      ? rightCd.implicitWidth + 60 : 300
    implicitHeight: rightBg.height

    color: "transparent"

    mask: Region {
      item: rightBg
    }

    Item {
      anchors.fill: parent

      RightBackground {
        id: rightBg
        anchors.right: parent.right
        height:
          (rightWindow.activeMenu === RightSection.ActiveMenu.Collapsed)
          ? 60 : 800
        width:
          (rightWindow.activeMenu === RightSection.ActiveMenu.Collapsed)
          ? rightCd.implicitWidth + 60 : 500

        Behavior on height {
          NumberAnimation {
            duration: 350
            easing.type: Easing.OutExpo
          }
        }

        Behavior on width {
          NumberAnimation {
            duration: 350
            easing.type: Easing.OutExpo
          }
        }

        RightCollapsed {
          id: rightCd
        }

        RightExpanded {
          id: rightExp
        }
      }
    }
  }
}
