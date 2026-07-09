import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell
import "../widgets/"
import "../containers/"
import "../services/"

Item {
  id: rExpanded
  anchors {
    top: parent.top
    bottom: parent.bottom
    right: parent.right
  }

  implicitWidth: parent.width - 24

  clip: true
  visible: (rightWindow.activeMenu !== RightSection.ActiveMenu.Collapsed)

  StackLayout {
    Layout.fillWidth: true
    Layout.fillHeight: true
    currentIndex: rightWindow.activeMenu === RightSection.ActiveMenu.Bluetooth ? 0 :
      rightWindow.activeMenu === RightSection.ActiveMenu.Conn ? 1 : 2

    BluetoothWidget {
      Layout.fillWidth: true
      Layout.fillHeight: true
    }

    ConnWidget {
      Layout.fillWidth: true
      Layout.fillHeight: true
    }

    ClockWidget {
      Layout.fillWidth: true
      Layout.fillHeight: true
    }
  }

  ColumnLayout {
		id: rExpandedTabs
    spacing: 8

    anchors {
      fill: parent
      bottom: parent.bottom
    }

    RowLayout {
      Layout.fillWidth: true
      Layout.preferredHeight: 36
      Layout.leftMargin: 12
      Layout.rightMargin: 12
      Layout.bottomMargin: 36
      Layout.alignment: Qt.AlignBottom

      spacing: 12

      TabSelector {
        text: "Bluetooth"
        Layout.fillWidth: true
        isActive: rightWindow.activeMenu === RightSection.ActiveMenu.Bluetooth
        onClicked: rightWindow.activeMenu = RightSection.ActiveMenu.Bluetooth
      }

      TabSelector {
        text: "Connections"
        Layout.fillWidth: true
        isActive: rightWindow.activeMenu === RightSection.ActiveMenu.Conn
        onClicked: rightWindow.activeMenu = RightSection.ActiveMenu.Conn
      }

      TabSelector {
        text: "Clock"
        Layout.fillWidth: true
        isActive: rightWindow.activeMenu === RightSection.ActiveMenu.Clock
        onClicked: rightWindow.activeMenu = RightSection.ActiveMenu.Clock
      }

      TabSelector {
        text: ""
        Layout.fillWidth: false
        Layout.preferredWidth: 36
        onClicked: rightWindow.activeMenu = RightSection.ActiveMenu.Collapsed
      }
    }
	}
}
