import QtQuick 2.15
import QtQuick.Controls 2.15


ApplicationWindow {
  id: root
  width: 800
  height: 600
  visible: true
  title: "Viewer"

  Image {
      id: root_background_image
      anchors.fill: parent
      fillMode: Image.PreserveAspectCrop
      source: "Images/robo_background.jpg"
      sourceSize.width: root.width
      sourceSize.height: root.height
  }

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

      background: Rectangle {
          color: "#00ff7f"
          radius: startButton.radius
      }

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

      background: Rectangle {
          color: "red"
          radius: controllersButton.radius
      }

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
      width: 800
      height: 600
      visible: false

      Image {
          id: controllers_back_image
          anchors.fill: parent
          fillMode: Image.PreserveAspectCrop
          source: "Images/controllers_back.jpg"
          sourceSize.width: controllerWindow.width
          sourceSize.height: controllerWindow.height
      } // Background

      Component {
          id: arrowComponent
          Item {
              id: arrowContainer
              width: 150
              height: 150
              Rectangle {
                  id: recImage
                  width: 150
                  height: 150
                  anchors.horizontalCenter: parent.horizontalCenter
                  anchors.verticalCenter: parent.verticalCenter
                  radius: 5
                  color: "red"
                  border.color: centralRectangle.border.color
                  border.width: 5

                  Image {
                      id: arrowImage
                      width: 100
                      height: 100
                      anchors.centerIn: recImage
                      source: "Images/facing-Arrow.jpg"
                      visible: false
                  }

                  ShaderEffect {
                      id: joystick
                      anchors.centerIn: recImage
                      width: arrowImage.width
                      height: arrowImage.height
                      property variant source: arrowImage
                      property color customColor: "yellow"
                      property real rotation: arrowContainer.parent.customRotation
                      property real customWidth: arrowImage.width
                      property real customHeight: arrowImage.height
                      fragmentShader: "shaders/color_overlay_shader.frag.qsb"
                      vertexShader: "shaders/arrow_direction.vert.qsb"
                  }// Shader Effect for color of arrows

                  MouseArea {
                      anchors.fill: parent
                      onClicked: {
                          console.log("Arrow clicked:", joystick.rotation)
                      }
                  }
              } // Rectangle for image

          }

      } // Arrow Component

      //Joystick
      Rectangle {
          id: centralRectangle
          width: 500
          height: 500
          anchors.centerIn: parent
          color: "#00ff7f"
          radius: 10
          border.width: 2
          border.color: "#708090"

          // Add the arrows
          Loader {
              id: upArrow
              sourceComponent: arrowComponent
              anchors.horizontalCenter: parent.horizontalCenter
              anchors.top: parent.top
              active: true
              property real customRotation: 270
          }

          Loader {
              id: leftArrow
              sourceComponent: arrowComponent
              anchors.verticalCenter: parent.verticalCenter
              anchors.left: parent.left
              active: true
              property real customRotation: 180
          }

          Loader {
              id: rightArrow
              sourceComponent: arrowComponent
              anchors.verticalCenter: parent.verticalCenter
              anchors.right: parent.right
              active: true
              property real customRotation: 0
          }

          Loader {
              id: bottomArrow
              sourceComponent: arrowComponent
              anchors.horizontalCenter: parent.horizontalCenter
              anchors.bottom: parent.bottom
              active: true
              property real customRotation: 90
          }

      } // Central rectangle for joystick

  } // Controller Window

}// Application Window





