import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Row {
  spacing: 10
  Repeater {
    property var spaces: Hyprland.toplevels.values.map(top => top.workspace ? top.workspace.id : 0).filter(id => id > 0)

    onSpacesChanged: {
      console.log(spaces)
    }

    model: Math.max(
      Hyprland.focusedWorkspace?.id,
      ...spaces
    )

    Text {
      property var ws:
      Hyprland.workspaces.values.find(w => w.id === index + 1)
      property bool isActive:
      Hyprland.focusedWorkspace?.id === (index + 1)
      text: {
        const wsWindows = Hyprland.toplevels.values.filter(
          top => top.workspace && top.workspace.id === index + 1
        );

        let active = wsWindows.find(top => top.activated === true);

        if (!active && wsWindows.length > 0) {
          active = wsWindows[0];
        }

        if (isActive) return index + 1;
        if (wsWindows.length === 0) return "󰆢";
        if (active.title.startsWith("nvim ")) return "";
        if (active.title.startsWith("Yazi: ")) return "󱧶";
        if (active.title.startsWith("fish ")) return "";
        if (active.title.endsWith(" Zen Browser")) return "󰖟";
        return "";
      }

      color: isActive ? window.foreBright :
      (ws ? window.foreMid : window.foreMuted)
      font {
        pixelSize: window.fontSizeLg
        bold: isActive
        family: window.fontFam
      }

      renderType: Text.NativeRendering

      MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch(
          `hl.dsp.focus({ workspace = ${index + 1} })`)
        cursorShape: isActive ? Qt.ArrowCursor : Qt.PointingHandCursor
      }
    }
  }
}
