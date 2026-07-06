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

  color: adapter !== null ? window.foreBright : window.foreMid
  font {
    family: window.fontFam
    pixelSize: window.fontSizeMed
  }
}
