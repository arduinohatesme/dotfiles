import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell

Shape {
  id: leftBg
  anchors.fill: parent
  layer.enabled: true

  readonly property int radius: parent.height / 2

  ShapePath {
    fillColor: window.back
    strokeColor: "transparent"
    strokeWidth: 0

    startX: 0
    startY: 0

    PathLine {
      x: 0
      y: 
    }

    PathLine {
      x: middle.width - (middle.radius * 2)
      y: middle.height
    }

    PathArc {
      x: middle.width - middle.radius
      y: middle.height - middle.radius
      radiusX: middle.radius
      radiusY: middle.radius
      useLargeArc: false
      direction: PathArc.Counterclockwise
    }

    PathArc {
      x: middle.width
      y: 0
      radiusX: middle.radius
      radiusY: middle.radius
      useLargeArc: false
      direction: PathArc.Clockwise
    }

    PathLine {
      x: 0
      y: 0
    }
  }
}
