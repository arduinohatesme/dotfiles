pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  property string fmt: "ddd, d - hh:mm:ss"
  readonly property string time: {
    Qt.formatDateTime(clock.date, fmt)
  }
  readonly property var sysClock: clock

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
