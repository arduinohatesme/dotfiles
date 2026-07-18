import QtQuick
import Quickshell
import "../services/"

Rectangle {
  id: btCard
  visible: rightWindow.targetExpanded
  color: Theme.cardBack
  radius: Theme.cardCornerRadius
}
