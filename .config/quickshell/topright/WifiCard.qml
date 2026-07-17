import QtQuick
import Quickshell
import "../services/"

Rectangle {
  id: wifiCard
  visible: rightWindow.targetExpanded
  color: Theme.cardBack
  radius: Theme.cardCornerRadius
}
