import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick3D

Page {
    title: "MainPage"
    visible: true
    width: 400
    height: 800

    View3D {
       anchors.fill: parent

       environment: SceneEnvironment {
           backgroundMode: SceneEnvironment.Color
           clearColor: "#202030"
       }

       PerspectiveCamera {
           id: camera
           position: Qt.vector3d(0, 120, 400)
           eulerRotation.x: -10
       }

       DirectionalLight {
           eulerRotation.x: -30
           eulerRotation.y: -20
           brightness: 1.2
       }

       Model {
           id: cube
           source: "#Cube"
           position: Qt.vector3d(0, 0, 0)
           scale: Qt.vector3d(2, 2, 2)

           materials: PrincipledMaterial {
               baseColor: "tomato"
               roughness: 0.3
               metalness: 0.1
           }

           NumberAnimation on eulerRotation.y {
               from: 0
               to: 360
               duration: 4000
               loops: Animation.Infinite
           }
       }

       Model {
           source: "#Rectangle"
           position: Qt.vector3d(0, -120, 0)
           scale: Qt.vector3d(4, 4, 4)
           eulerRotation.x: -90

           materials: DefaultMaterial {
               diffuseColor: "#808080"
           }
       }
   }

}