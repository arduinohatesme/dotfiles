import QtQuick
import QtQuick.Layouts
import Quickshell
import "../widgets/"
import "../containers/"
import "../services/"

Item {
  anchors {
    top: parent.top
    bottom: parent.bottom
    right: parent.right
  }
  width: parent.width - 20
  implicitWidth: rightLayoutCollapsed.implicitWidth

  clip: true
  visible: (rightWindow.activeMenu === RightSection.ActiveMenu.Collapsed)

  RowLayout {
    id: rightLayoutCollapsed
    height: 40
    layoutDirection: Qt.LeftToRight
    spacing: 24

    anchors {
      top: parent.top
      right: parent.right
      rightMargin: 18
    }

    BluetoothWidget {
      Layout.alignment: Qt.AlignVCenter
      onBlueClicked: {
        rightWindow.activeMenu =
          (rightWindow.activeMenu === RightSection.ActiveMenu.Collapsed) ?
          RightSection.ActiveMenu.Bluetooth : RightSection.ActiveMenu.Collapsed
      }
    }

    ConnWidget {
      Layout.alignment: Qt.AlignVCenter
      onConnClicked: {
        rightWindow.activeMenu =
          (rightWindow.activeMenu === RightSection.ActiveMenu.Collapsed) ?
          RightSection.ActiveMenu.Conn : RightSection.ActiveMenu.Collapsed
      }
    }

    ClockWidget {
      Layout.alignment: Qt.AlignVCenter
      onTimeClicked: {
        rightWindow.activeMenu =
          (rightWindow.activeMenu === RightSection.ActiveMenu.Collapsed) ?
          RightSection.ActiveMenu.Clock : RightSection.ActiveMenu.Collapsed
      }
    }
  }
}
