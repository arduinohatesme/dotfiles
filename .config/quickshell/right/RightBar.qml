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

    implicitHeight: (activeMenu === RightSection.ActiveMenu.Collapsed) ? 60 : 200
    color: "transparent"

    mask: Region {
      item: rightBg
    }

    // Collapsed
    Item {
      anchors.fill: parent

      RightBackground {
        id: rightBg
        anchors.right: parent.right

        Behavior on width {
          NumberAnimation {
            duration: 350
            easing.type: Easing.OutExpo
          }
        }

        Behavior on height {
          NumberAnimation {
            duration: 350
            easing.type: Easing.OutExpo
          }
        }

        Item {
          anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
          }
          width: parent.width - (height / 2)

          clip: true

          RowLayout {
            id: rightLayout
            height: 40
            layoutDirection: Qt.LeftToRight
            spacing: 24

            anchors {
              top: parent.top
              right: parent.right
              rightMargin: 22
            }

            BluetoothWidget {
              Layout.alignment: Qt.AlignVCenter
              onBlueClicked: {
                rightWindow.activeMenu = RightSection.ActiveMenu.Bluetooth
              }
            }

            ConnWidget {
              Layout.alignment: Qt.AlignVCenter
              onConnClicked: {
                rightWindow.activeMenu = RightSection.ActiveMenu.Conn
              }
            }

            ClockWidget {
              Layout.alignment: Qt.AlignVCenter
              onTimeClicked: {
                rightWindow.activeMenu = RightSection.ActiveMenu.Clock
              }
            }
          }
        }
      }
    }

    Item {
      anchors.fill: parent
    }
  }
}
