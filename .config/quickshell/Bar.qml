import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell
import "./topright/"

Scope {
  id: window

  MiddleBar {}
  Variants {
    model: Quickshell.screens
    TopRightBar {}
  }
}
