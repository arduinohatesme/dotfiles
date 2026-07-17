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
  clip: true
  visible: rightWindow.targetExpanded

  property bool targetStateExpanded: false

  ScrollView {
    id: trExpPage
    visible: (opacity !== 0)
    opacity: rightWindow.targetExpanded ? 1.0 : 0.0
    ScrollBar.horizontal.visible: false
    ScrollBar.vertical.visible: false

    anchors {
      margins: 24
      top: parent.top
      topMargin: 10
      bottom: parent.bottom
      right: parent.right
      left: parent.left
      leftMargin: Theme.cornerRadius + 24
    }

    ColumnLayout {
      id: trColumnLayout
      spacing: 12
      width: trExpPage.availableWidth

      TopRightTimeHeader {
        id: timeHeader
        Layout.fillWidth: true
      }

      Rectangle {
        Layout.bottomMargin: 12
        Layout.fillWidth: true
        height: 1
        color: Theme.cardBack
      }

      RowLayout {
        Layout.fillWidth: true
        Layout.preferredHeight: 80
        TopRightWifiCard {
          id: wifiCard
          Layout.fillWidth: true
          Layout.fillHeight: true
        }

        TopRightWifiCard {
          id: settingsCardTwo
          Layout.fillWidth: true
          Layout.fillHeight: true
        }

        TopRightWifiCard {
          id: caffeineCard
          Layout.preferredWidth: 80
          Layout.fillHeight: true
        }
      }
    }
  }
}
