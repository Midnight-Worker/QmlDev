import QtQuick
import QtQuick3D

Node {
    id: node

    // Resources
    PrincipledMaterial {
        id: principledMaterial
        metalness: 1
        roughness: 1
        alphaMode: PrincipledMaterial.Opaque
    }

    // Nodes:
    Model {
        id: suzanne
        objectName: "Suzanne"
        source: "meshes/suzanne_mesh.mesh"
        materials: [
            principledMaterial
        ]
    }

    // Animations:
}
