//
//  ScrollView.swift
//  ARWeather
//
//  Created by Diego Castro on 03/03/22.
//

import SwiftUI
import RealityKit

struct ScrollContentView: View {
    var models = ["1", "2", "3", "4"]
    @Environment(\.colorScheme) var colorScheme
    @Binding var bodyOptions: Bool
    @Binding var modelIndex: Int
    var body: some View {
        ZStack {
            LinearGradient( gradient: Gradient(colors:  [.blue.opacity(0.1), .blue.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Button {
                    bodyOptions = false
                } label: {
                    Text ("Cancel")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                ScrollView(){
                    VStack(spacing:50){
                        ForEach(0...1, id: \.self){ index in
                            Button{
                                ARViewController.shared.selectedModel = index
                                bodyOptions = false
                                
                                if colorScheme == .dark { modelIndex = index+2 } else {
                                    modelIndex = index
                                }
                                
                            } label: {
                                
                                ZStack {
                                    ZStack {
                                        Image(uiImage: UIImage(named: models[index])!)
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.width*(2.4/5), height: UIScreen.main.bounds.height*(1.5/5))
                                        
                                    }
                                    .frame(width: UIScreen.main.bounds.width*(3.3/5), height: UIScreen.main.bounds.height*(1.9/5))
                                }
                                .background(Color.white.opacity(0.5))
                                .cornerRadius(16)
                                .overlay(  RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.black, lineWidth: 0.5))
                            }
                            
                            .buttonStyle(PlainButtonStyle())
                            
                        }
                        
                    }
                    
                    
                } .padding()
            }
        }
    }
}

struct ScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollContentView( bodyOptions: .constant(true), modelIndex: .constant(1))
    }
}
