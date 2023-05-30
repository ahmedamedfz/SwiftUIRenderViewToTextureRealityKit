//
//  Coordinator.swift
//  RenderViewToTexture
//
//  Created by Ahmad Fariz on 30/05/23.
//

import Foundation
import RealityKit
import UIKit

class Coordinator: NSObject {
    let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    weak var view: ARView?
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        guard let view = self.view else { return }
        
        let tapLocation = recognizer.location(in: view)
        let results = view.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let result = results.first {
            
            let anchorEntity = AnchorEntity(raycastResult: result)
            
            let modelEntity = ModelEntity(mesh: MeshResource.generateBox(width: 0.6, height: 0.2, depth: 0.6))
            modelEntity.generateCollisionShapes(recursive: true)
            
            modelEntity.model?.materials = [createTexture(drawing: viewModel.drawing?.cgImage)]
            anchorEntity.addChild(modelEntity)
            view.scene.addAnchor(anchorEntity)
            
            view.installGestures(.all, for: modelEntity)
        }
    }
    func createTexture(drawing: CGImage?) -> SimpleMaterial{
        if drawing == nil {
            return SimpleMaterial(color: .white, roughness: .float(0), isMetallic: false)
        }
        else
        {
            let texture = try! TextureResource.generate(from: drawing!, options: .init(semantic: .normal))
            var material = SimpleMaterial()
            material.color = .init(texture: .init(texture))
            material.roughness = .float(0)
            material.metallic = .float(0)
            
            return material
        }
    }
}
