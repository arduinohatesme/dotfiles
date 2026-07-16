import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import "../widgets/"
import "../services/"

Item {
  id: rExpanded
  anchors.fill: parent

  implicitWidth: parent.width - 25

  clip: true
  visible: rightWindow.targetExpanded

  property bool targetStateExpanded: false

  ScrollView {
    id: trExpPage
    visible: (opacity !== 0)
    opacity: rightWindow.targetExpanded ? 1.0 : 0.0
    anchors {
      margins: 20
      top: parent.top
      topMargin: 12
      bottom: parent.bottom
      right: parent.right
      left: parent.left
      leftMargin: 40
    }

    ColumnLayout {
      id: trColumnLayout
      width: trExpPage.availableWidth
      spacing: 12

      TopRightTimeHeader {
        id: timeHeader
        Layout.fillWidth: true
      }

      Rectangle {
        Layout.fillWidth: true
        height: 1
        color: Theme.cardBack
      }

      TopRightSettingsCard {
        id: settingsCard
        Layout.preferredHeight: 80
        Layout.preferredWidth: 200
      }
    }
  }
}
