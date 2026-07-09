import QtQuick
import QtQuick.Layouts
import Quickshell
import "../widgets/"
import "../containers/"
import "../services/"

Item {
  id: rightCollapsedRoot
  anchors {
    top: parent.top
    bottom: parent.bottom
    right: parent.right
  }
  width: parent.width - 20
  implicitWidth: rightLayoutCollapsed.implicitWidth

  clip: true
  visible: (!rightWindow.targetExpanded)

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
    }

    ConnWidget {
      Layout.alignment: Qt.AlignVCenter
    }

    ClockWidget {
      Layout.alignment: Qt.AlignVCenter
    }
  }

  signal rightCollapsedClicked()

  MouseArea {
    id: rightMouseArea
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor

    onClicked: {
      rightCollapsedClicked()
    }
  }
}
