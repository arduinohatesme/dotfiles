pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Bluetooth

Singleton {
  id: bluetoothService

  readonly property var adapter: Bluetooth.defaultAdapter
  readonly property int numConnected: adapter.devices.values.length
}
