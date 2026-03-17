import QtQuick
import QtQuick.Controls
import QtQuick3D

Page {
    title: "MainPage"

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
            id: testCube
            source: "#Cube"
            position: Qt.vector3d(-120, 0, 0)
            scale: Qt.vector3d(1, 1, 1)

            materials: DefaultMaterial {
                diffuseColor: "red"
            }
        }

        Model {
            id: suzanne
            source: "meshes/suzanne_mesh.mesh"
            position: Qt.vector3d(80, 0, 0)
            scale: Qt.vector3d(50, 50, 50)
            eulerRotation.y: -90

            materials: PrincipledMaterial {
                metalness: 0.0
                roughness: 0.5
                baseColor: "#c8c8c8"
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