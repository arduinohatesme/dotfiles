import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import "../widgets/"
import "../services/"

Item {
  id: rExpanded
  anchors {
    top: parent.top
    bottom: parent.bottom
    right: parent.right
  }

  implicitWidth: parent.width - 25

  clip: true
  visible: !rightWindow.targetExpanded

  property bool targetStateExpanded: false

  ScrollView {
    id: trExPage
    Layout.fillWidth: true
    Layout.fillHeight: true
    visible: (opacity !== 0)
    opacity: rightWindow.targetExpanded ? 1.0 : 0.0

    ColumnLayout {
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
  }
}
