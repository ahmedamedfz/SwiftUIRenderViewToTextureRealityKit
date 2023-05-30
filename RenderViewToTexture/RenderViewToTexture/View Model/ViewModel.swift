//
//  ARViewModel.swift
//  RenderViewToTexture
//
//  Created by Ahmad Fariz on 30/05/23.
//

import Foundation
import UIKit
import PencilKit

class ViewModel: ObservableObject{
    @Published var drawing: UIImage?
    @Published var canvasView = PKCanvasView()
    @Published var isShowingView = false
}

extension PKCanvasView {
    func asImage() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        
        let image = renderer.image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
        
        return image
    }
}
