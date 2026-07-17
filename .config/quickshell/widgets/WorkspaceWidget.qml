import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "../services"

Row {
  id: workspaceRow
  spacing: 10
  Repeater {
    id: wsRepeater
    property var spaces: Hyprland.toplevels.values
      .map(top => top.workspace ? top.workspace.id : 0)
      .filter(id => id > 0)
    property var activeWindows: []

    model: Math.max(
      Hyprland.focusedWorkspace?.id,
      ...spaces
    )

    Item {
      id: wsItem

      width: Theme.fontSizeLg * 2
      height: Theme.fontSizeLg * 2
      property int transitionMs: 120

      function getIcon() {
        const wsWindows = Hyprland.toplevels.values.filter(
          top => top.workspace && top.workspace.id === index + 1
        );

        if (Hyprland.focusedWorkspace.id === index + 1) {
          wsRepeater.activeWindows[index + 1] = Hyprland.activeToplevel
        }

        const active = wsRepeater.activeWindows[index + 1]

        if (wsWindows.length === 0) return "󰆢";
        if (active.title.startsWith("nvim ")) return "";
        if (active.title.startsWith("Yazi: ")) return "󱧶";
        if (active.title.startsWith("fish ")) return "";
        if (active.title.endsWith("Zen Browser")) return "󰖟";
        return "";
      }

      property var ws:
        Hyprland.workspaces.values.find(w => w.id === index + 1)
      property bool isActive:
        Hyprland.focusedWorkspace?.id === (index + 1)

      Text {
        id: active
        anchors.centerIn: parent
        text: index + 1
        color: Theme.foreBright

        font {
          pixelSize: Theme.fontSizeLg
          bold: true
          family: Theme.fontFam
        }
        renderType: Text.NativeRendering

        opacity: wsItem.isActive ? 1.0 : 0.0
        Behavior on opacity {
          NumberAnimation { duration: transitionMs; easing.type: Easing.InOutQuad }
        }
      }

      Text {
        id: inactive
        anchors.centerIn: parent
        text: wsItem.getIcon()
        color: wsItem.ws ? Theme.foreMid : Theme.foreMuted

        font {
          pixelSize: Theme.fontSizeLg
          bold: false
          family: Theme.fontFam
        }
        renderType: Text.NativeRendering

        opacity: wsItem.isActive ? 0.0 : 1.0
        Behavior on opacity {
          NumberAnimation { duration: transitionMs; easing.type: Easing.InOutQuad }
        }
      }

      MouseArea {
        anchors.fill: parent
        cursorShape: isActive ? Qt.ArrowCursor : Qt.PointingHandCursor
        onClicked: {
          if (!isActive) {
            Hyprland.dispatch(`hl.dsp.focus({ workspace = ${index + 1} })`)
          }
        }
      }
    }
  }
}
