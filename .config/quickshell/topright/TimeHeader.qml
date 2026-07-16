import QtQuick
import QtQuick.Layouts
import Quickshell
import "../services/"

ColumnLayout {
  spacing: 0
  Text {
    text: Qt.formatDateTime(Time.sysClock.date, "hh:mm:ss")
    color: Theme.headBright
    font {
      pixelSize: Theme.fontSizeHead
      family: Theme.fontFam
    }
  }

  Text {
    text: Qt.formatDateTime(Time.sysClock.date, "dddd, MMMM d")
    color: Theme.headMid
    font {
      pixelSize: Theme.fontSizeMed
      family: Theme.fontFam
    }
  }
}
