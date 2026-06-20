import QtQuick 6.0
import QtQuick.Controls 6.0
import SddmComponents 2.0

Item {
  id: root
  width: Screen.width
  height: Screen.height

  FontLoader {
    id: pixelFont
    source: "born2bsporty-fs.otf"
  }

  Image {
    id: background
    anchors.fill: parent
    source: "background.png"

    smooth: false
    fillMode: Image.PreserveAspectCrop
  }

  MultiEffect {
    id: glassBlur
    anchors.fill: loginCard
    source: background

    blurEnabled: true
    blur: 0.5

    sourceRect: Qt.rect(loginCard.x, loginCard.y, loginCard.width, loginCard.height)
  }

  Rectangle {
    id: loginCard
    width: 420
    height: 480
    anchors.centerIn: parent
  }
}
