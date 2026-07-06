import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Row {
  spacing: 10
  Repeater {
    model: Math.max(
      Hyprland.workspaces.values.length,
      Hyprland.focusedMonitor.activeWorkspace.id)

    Text {
      property var ws:
      Hyprland.workspaces.values.find(w => w.id === index + 1)
      property bool isActive:
      Hyprland.focusedWorkspace?.id === (index + 1)
      text: ""

      color: isActive ? window.foreBright :
      (ws ? window.foreMid : window.foreMuted)
      font {
        pixelSize: window.fontSizeLg
        bold: isActive
        family: window.fontFam
      }

      MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch(
          `hl.dsp.focus({ workspace = ${index + 1} })`)
        cursorShape: isActive ? Qt.ArrowCursor : Qt.PointingHandCursor
      }
    }
  }
}
