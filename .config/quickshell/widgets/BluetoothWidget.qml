import QtQuick
import Quickshell
import "../services"

Text {
  id: blueRoot

  text: {
    if (Bluetooth.numConnected) return "󰂱"
    return "󰂲"
  }

  visible: Bluetooth.adapter !== null

  color: (Bluetooth.numConnected) ? Theme.foreBright : Theme.foreMid
  font {
    family: Theme.fontFam
    pixelSize: Theme.fontSizeMed
  }
}
