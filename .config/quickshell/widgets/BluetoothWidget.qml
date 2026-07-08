import QtQuick
import Quickshell
import Quickshell.Bluetooth

Text {
  id: btStat

  readonly property var adapter: Bluetooth.defaultAdapter

  text: {
    if (adapter === null) return "󰂲"
    if (adapter.devices.values.length >= 1) return "󰂱"
    return ""
  }

  color: adapter !== null ? Theme.foreBright : Theme.foreMid
  font {
    family: Theme.fontFam
    pixelSize: Theme.fontSizeMed
  }
}
