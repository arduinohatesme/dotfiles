import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell
import "../services"

Shape {
  id: rightContainer

  layer {
    enabled: true
    samples: 8
  }

  width: parent.width
  height: parent.height

  readonly property int r: 20
  readonly property int h: height - 20

  ShapePath {
    fillColor: Theme.back
    strokeColor: "transparent"
    strokeWidth: 0

    startX: 0
    startY: 0

    PathArc {
      x: rightContainer.r
      y: rightContainer.r
      radiusX: rightContainer.r
      radiusY: rightContainer.r
      useLargeArc: false
      direction: PathArc.Clockwise
    }

    PathLine {
      x: rightContainer.r
      y: rightContainer.h - rightContainer.r
    }

    PathArc {
      x: rightContainer.r * 2
      y: rightContainer.h
      radiusX: rightContainer.r
      radiusY: rightContainer.r
      useLargeArc: false
      direction: PathArc.Counterclockwise
    }

    PathLine {
      x: rightContainer.width - rightContainer.r
      y: rightContainer.h
    }

    PathArc {
      x: rightContainer.width
      y: rightContainer.h + rightContainer.r
      radiusX: rightContainer.r
      radiusY: rightContainer.r
      useLargeArc: false
      direction: PathArc.Clockwise
    }

    PathLine {
      x: rightContainer.width
      y: 0
    }

    PathLine {
      x: 0
      y: 0
    }
  }
}
