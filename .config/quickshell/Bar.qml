import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell
import "./right/"

Scope {
  id: window

  MiddleBar {}
  Variants {
    model: Quickshell.screens
    RightBar {}
  }
}
