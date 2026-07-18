import QtQuick
import Quickshell
import Quickshell.Io
import "../services/"

Rectangle {
  id: caffCard
  visible: rightWindow.targetExpanded
  color: Theme.cardBack
  radius: Theme.cardCornerRadius

  property bool idleEnabledStatus: false
  property bool idleEnabledChecked: false
  property bool toggleOnCheckStep: true

  Text {
    anchors.centerIn: parent
    color: Theme.foreBright
    font.pixelSize: Theme.fontSizeLg + 16
    text: caffCard.idleEnabledStatus ? "󰅶" : "󰛊"
  }

  Process {
    id: checkInitIdleStatus
    running: false
    command: [ "killall", "-s", "0", "hypridle" ]
    onExited: (exitCode, exitStatus) => {
      caffCard.idleEnabledStatus = exitCode
      caffCard.idleEnabledChecked = true
    }
  }

  Process {
    id: toggleIdleStatus
    running: false
    command: [ "killall", "-s", "0", "hypridle" ]
    onExited: (exitCode, exitStatus) => {
      if (!caffCard.toggleOnCheckStep) {
        caffCard.toggleOnCheckStep = true
        return;
      }

      if (exitCode === 0) {
        caffCard.idleEnabledStatus = true
        caffCard.toggleOnCheckStep = false
        toggleIdleStatus.exec([ "killall", "hypridle" ])
      } else {
        caffCard.idleEnabledStatus = false
        caffCard.toggleOnCheckStep = false
        toggleIdleStatus.exec([ "hyprctl", "dispatch", "hl.dsp.exec_cmd(\"hypridle\")"])
      }
    }
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      toggleIdleStatus.running = true
    }
  }

  Component.onCompleted: {
    checkInitIdleStatus.running = true
  }
}
