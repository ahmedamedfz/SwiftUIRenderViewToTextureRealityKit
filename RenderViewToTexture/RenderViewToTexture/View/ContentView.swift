//
//  ContentView.swift
//  RenderViewToTexture
//
//  Created by Ahmad Fariz on 30/05/23.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @EnvironmentObject var viewModel : ViewModel
    var body: some View {
        ZStack{
            ARViewContainer().edgesIgnoringSafeArea(.all)
            button.padding(50)
            
        }.sheet(isPresented: $viewModel.isShowingView,onDismiss: {viewModel.isShowingView = false}){
            DrawView().presentationDetents([.medium])
        }
    }
    var button : some View {
        HStack{
            VStack{
                Spacer()
                Button(action: {viewModel.isShowingView = true}){
                    ZStack {
                        Circle()
                            .foregroundColor(.blue)
                            .frame(width: 50, height: 50)
                        
                        Image(systemName: "scribble")
                            .imageScale(.large)
                            .foregroundColor(.white)
                    }
                }
            }
            Spacer()
        }
    }
    
}

struct ARViewContainer: UIViewRepresentable {
    @EnvironmentObject var viewModel: ViewModel
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap)))
        
        context.coordinator.view = arView
        return arView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}


#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
