//
//  DrawView.swift
//  RenderViewToTexture
//
//  Created by Ahmad Fariz on 30/05/23.
//


import SwiftUI
import UIKit
import PencilKit

struct DrawView: View {
    @EnvironmentObject var viewModel:ViewModel
    @State var selectedColor:Color = .black
    var body: some View {
        NavigationView {
            ZStack {
                DrawingView(canvasView: $viewModel.canvasView, selectedColor: $selectedColor)
                VStack {
                    HStack(spacing: 10) {
                        Spacer()
                        ColorPicker("Color", selection: $selectedColor)
                            .labelsHidden()
                        Button(action: {
                            viewModel.canvasView.drawing = PKDrawing()
                        }) {
                            Text("Clear")
                                .foregroundColor(.red)
                        }
                        Button(action: {
                            convertPencilKitViewToImage()
                            viewModel.isShowingView = false
                        }) {
                            Text("Done")
                        }
                    }
                    .padding(20)
                    Spacer()
                }
            }
            .onAppear {
                viewModel.canvasView.drawing = PKDrawing()
            }
        }
    }
    func convertPencilKitViewToImage(){
        if let image = viewModel.canvasView.asImage(){
            // save the image to user defaults or perform any further operations
            viewModel.drawing = image
        }
    }
}
struct DrawingView: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    @Binding var selectedColor: Color
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 3.0)
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.tool = PKInkingTool(.pen, color: UIColor(selectedColor), width: 3.0)
    }
}

struct DrawView_Previews: PreviewProvider {
    static var previews: some View {
        DrawView()
    }
}
