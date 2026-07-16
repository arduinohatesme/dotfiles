pragma Singleton

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Networking
import "../services/"

Singleton {
  id: connService

  readonly property var primary: {
    for (let i = 0; i < Networking.devices.values.length; i++) {
      let d = Networking.devices.values[i]
      if (d.connected && d.networks.values.length >= 1) {
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
}
