import QtQuick 2.15
import QtQuick.Controls 2.15
import com.example 1.0


ApplicationWindow {
  id: root
  width: 800
  height: 600
  visible: true
  title: "Viewer"

  property alias startTimeInfo: startTimeInfo

  RoundButton {
      id: startButton
      text: "Start"
      x: 10
      y: 10
      radius: 20
      width: 100
      height: 40
      font.pixelSize: 16
      onClicked: {
          console.log("Start button clicked")
      }
  }
  RoundButton {
      id: controllersButton
      text: "Controllers"
      anchors.top: parent.top
      anchors.topMargin: 10
      anchors.right: parent.right
      anchors.rightMargin: 10
      width: 100
      height: 40
      radius: 20
      font.pixelSize: 16
      onClicked: {
          console.log("Controllers button clicked")
          controllerWindow.show()
      }
  }

  Rectangle {
      id: infoRectangle
      anchors.bottom: parent.bottom
      anchors.left: parent.left
      anchors.right: parent.right
      height: 60
      color: "#EEE"

      Text {
          id: startTimeInfo
          text: monitor.timeInfo
          anchors.centerIn: parent
          color: "black"
      }

      Timer {
          id: updateTimeTimer
          interval: 1000 // Update every 1 second
          running: true
          repeat: true
          onTriggered: {
              startTimeInfo.text = monitor.timeInfo
          }
      }
  }

  Window {
      id: controllerWindow
      title: "Controllers"
      width: 300
      height: 300
      visible: false

      ShaderLoader {
          id: shaderLoaderInstance
      }

      //Arrow Component
      Component {
          id: arrowComponent
          Image {
              id: arrowImage
              width: 80; height: width
              source: ":/Images/arrow_black.jpg"
              property string loadedShader: ""

              ShaderEffect {
                  id: colorEffect
                  anchors.fill: arrowImage
                  property variant source: arrowImage
                  property color alphaChannel: "black"
                  fragmentShader: "qrc:/color_overlay_shader.frag.qsb"
                  vertexShader: "qrc:/arrow_direction.vert.qsb"
              }// Shader Effect for color of arrows


              MouseArea {
                  anchors.fill: parent
                  onClicked: {
                      console.log("Arrow clicked:", arrowImage.rotation)
                  }
              }
          }

      }// Component

      Loader {
          id: upArrow
          sourceComponent: arrowComponent
      }

//      Column {
//          anchors.centerIn: parent
//          anchors.horizontalCenterOffset: 50
//          spacing: 20

//          Button {
//              text: "Up"
//              onClicked: console.log("Up button clicked")
//          }

//          Row {
//              spacing: 20
//              Button {
//                  text: "Left"
//                  onClicked: console.log("Left button clicked")
//              }

//              Button {
//                  text: "Right"
//                  onClicked: console.log("Right button clicked")
//              }
//          }

//          Button {
//              text: "Down"
//              onClicked: console.log("Down button clicked")
//          }
//      }
  }

}// Application Window





