import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import "../services/"

Text {
  id: volumeRoot

  PwObjectTracker {
    objects: [ Pipewire.defaultAudioSink ]
  }

  property bool shouldShowOsd: false
  property var prevVolume: -1.0
  property var volume: Pipewire.defaultAudioSink?.audio.volume
  property string changeIndicator

  onVolumeChanged: {
    if (volume > prevVolume) {
      prevVolume = volume
      volumeRoot.changeIndicator = "󰝝"
    } else {
      volumeRoot.changeIndicator = "󰝞"
    }

    prevVolume = volume
    changeTimer.restart()
  }

  Timer {
    id: changeTimer
    interval: 350
    repeat: false
    running: false
  }

  function getVolIcon() {
    if (Pipewire.defaultAudioSink === null) return "󰸈 "
    if (volume === 0) return "󰝟 "
    if (volume <= .1) return "󰕿 "
    if (volume <= .3) return "󰖀 "
    return "󰕾  "
  }

  Item {
    anchors.fill: parent
    Text {
      id: static
      text: "hi" // volumeRoot.getVolIcon()
      opacity: changeTimer.running ? 0.0 : 1.0
      Behavior on opacity {
        NumberAnimation { duration: 350; easing.type: Easing.InOutQuad }
      }

      color: (Pipewire.defaultAudioSink === null) ? Theme.foreMid : Theme.foreBright
      font {
        family: Theme.fontFam
        pixelSize: Theme.fontSizeMed
      }
    }

    Text {
      id: changed
      text: volumeRoot.changeIndicator
      height: Theme.fontSizeMed
      opacity: changeTimer.running ? 1.0 : 0.0
      Behavior on opacity {
        NumberAnimation { duration: 350; easing.type: Easing.InOutQuad }
      }

      color: (Pipewire.defaultAudioSink === null) ? Theme.foreMid : Theme.foreBright
      font {
        family: Theme.fontFam
        pixelSize: Theme.fontSizeMed
      }
    }
  }
}
