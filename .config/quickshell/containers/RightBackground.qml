import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell
import "../services"

Shape {
  id: rightBg
  anchors {
    fill: parent
  }
  layer {
    enabled: true
    samples: 8
  }

  readonly property int radius: rightBg.height / 3
  readonly property int h: radius * 2

  ShapePath {
    fillColor: Theme.back
    strokeColor: "transparent"
    strokeWidth: 0

    startX: 0
    startY: 0

    PathArc {
      x: rightBg.radius
      y: rightBg.radius
      radiusX: rightBg.radius
      radiusY: rightBg.radius
      useLargeArc: false
      direction: PathArc.Clockwise
    }

    PathArc {
      x: rightBg.h
      y: rightBg.h
      radiusX: rightBg.radius
      radiusY: rightBg.radius
      useLargeArc: false
      direction: PathArc.Counterclockwise
    }

    PathLine {
      x: rightBg.width - rightBg.radius
      y: rightBg.h
    }

    PathArc {
      x: rightBg.width
      y: rightBg.h + rightBg.radius
      radiusX: rightBg.radius
      radiusY: rightBg.radius
      useLargeArc: false
      direction: PathArc.Clockwise
    }

    PathLine {
      x: rightBg.width
      y: 0
    }

    PathLine {
      x: 0
      y: 0
    }
  }
}
