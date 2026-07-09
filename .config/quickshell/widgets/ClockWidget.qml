import QtQuick
import "../services/"

Text {
  id: clockRoot
  font {
    pixelSize: Theme.fontSizeMed
    family: Theme.fontFam
  }
  color: Theme.foreBright

  property int fmt: 0
  property var fmts: [
    "ddd, d - hh:mm:ss",
    "MM/dd/yyyy - hh:mm:ss t",
    "MM/dd - hh:mm",
    "dd - hh:mm",
    "h:mm AP",
  ]

  text: Time.time !== "" ? Time.time : fmts[fmt]
  renderType: Text.NativeRendering
}
