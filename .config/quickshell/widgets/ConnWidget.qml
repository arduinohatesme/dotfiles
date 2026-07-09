import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Networking
import "../services/"

Text {
  id: connRoot

  text: {
    if (Conns.ethernet) return ""
    if (Conns.wifi) {
      if (Conns.strength > 0.90) return "󰤨"
      if (Conns.strength > 0.75) return "󰤥"
      if (Conns.strength > 0.50) return "󰤢"
      return "󰤟"
    }
    return "󰤮"
  }

  renderType: Text.NativeRendering

  color: Conns.ethernet || Conns.wifi ? Theme.foreBright : Theme.foreMid
  font {
    family: Theme.fontFam
    pixelSize: Theme.fontSizeMed
  }
}
