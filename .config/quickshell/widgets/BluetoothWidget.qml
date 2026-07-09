import QtQuick
import Quickshell
import Quickshell.Bluetooth
import "../services"

Text {
  id: blueRoot

  text: {
    if (Bluetooth.adapter === null) return "󰂲"
    if (Bluetooth.numConnected >= 1) return "󰂱"
    return ""
  }

  color: Bluetooth.adapter !== null ? Theme.foreBright : Theme.foreMid
  font {
    family: Theme.fontFam
    pixelSize: Theme.fontSizeMed
  }
}
