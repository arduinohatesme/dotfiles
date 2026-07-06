import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Networking

Text {
  id: netStat

  readonly property var primary: {
    for (let i = 0; i < Networking.devices.values.length; i++) {
      let d = Networking.devices.values[i]
      if (d.connected) {
        return d;
      }
    }
  }

  property bool ethernet: primary && primary.type === DeviceType.Wired

  property bool wifi: primary && primary.type === DeviceType.Wifi

  property int strength: {
    if (ethernet) return 1;
    if (wifi && primary.network) {
      return primary.network.signalStrength;
    }
    return 0;
  }

  text: {
    if (ethernet) return ""
    if (wifi) {
      if (netStat.strength > 0.90) return "󰤨"
      if (netStat.strength > 0.75) return "󰤥"
      if (netStat.strength > 0.50) return "󰤢"
      return "󰤟"
    }
    return "󰤮"
  }

  color: ethernet || wifi ? window.foreBright : foreMid
  font {
    family: window.fontFam
    pixelSize: window.fontSizeMed
  }
}
