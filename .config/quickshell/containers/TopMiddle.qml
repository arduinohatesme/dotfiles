import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell
import "../services"

Shape {
  id: middleBg
  anchors.fill: parent
  layer {
    enabled: true
    samples: 8
  }

  readonly property int radius: Theme.cornerRadius

  ShapePath {
    fillColor: Theme.back
    strokeColor: "transparent"
    strokeWidth: 0

    startX: 0
    startY: 0

    PathArc {
      x: middleBg.radius
      y: middleBg.radius
      radiusX: middleBg.radius
      radiusY: middleBg.radius
      useLargeArc: false
      direction: PathArc.Clockwise
    }

    PathLine {
      x: middleBg.radius
      y: middleBg.height - middleBg.radius
    }

    PathArc {
      x: (middleBg.height * 0) + (middleBg.radius * 2) + (middleBg.width * 0)
      y: middleBg.height
      radiusX: middleBg.radius
      radiusY: middleBg.radius
      useLargeArc: false
      direction: PathArc.Counterclockwise
    }

    PathLine {
      x: middleBg.width - (middleBg.radius * 2)
      y: middleBg.height
    }

    PathArc {
      x: middleBg.width - middleBg.radius
      y: middleBg.height - middleBg.radius
      radiusX: middleBg.radius
      radiusY: middleBg.radius
      useLargeArc: false
      direction: PathArc.Counterclockwise
    }

    PathLine {
      x: middleBg.width - middleBg.radius
      y: middleBg.radius
    }

    PathArc {
      x: middleBg.width
      y: 0
      radiusX: middleBg.radius
      radiusY: middleBg.radius
      useLargeArc: false
      direction: PathArc.Clockwise
    }

    PathLine {
      x: 0
      y: 0
    }
  }
}
