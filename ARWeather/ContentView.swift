//
//  ContentView.swift
//  ARWeather
//
//  Created by Diego Castro on 20/01/22.
//

import ARKit
import RealityKit
import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    let Colors = Color(red: 0.898, green: 0.898, blue: 0.898)
    let Colors2 = Color(red: 0, green: 45, blue: 131)
    @State var ShowAR : Bool  =  false
    @ObservedObject var weatherManager = weatherNetworkManager()
    @State var selectedSizes = ARViewController.shared.selectedSize
    var body: some View {
        
        NavigationView {
            
         
            ZStack{
                
                if colorScheme == .dark {
                    Color.black

                } else {
                    LinearGradient( gradient: Gradient(colors:  [.white, .blue]), startPoint: .top, endPoint: .bottom)
                }

                VStack{
Text("""
    Pick the 3D body on which you would like to consult the weather
""")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                .font(.system(size: 24.0))
                    .font(.subheadline.weight(.bold))
                .padding(.bottom, 500)
                .padding(.trailing)
                .padding(.leading)
                
                                
                 ScrollContentView()
                
        ZStack{

            
            Button {
                ShowAR.toggle()
            } label: {
                Label("Go AR", systemImage: "camera.fill")
                    .foregroundColor(.black)
                    .font(.system(size: CGFloat(30)))
                    .frame(width: 200, height: 60, alignment: .center)
                    .overlay(
                          RoundedRectangle(cornerRadius: 10)
                              .stroke(Color.gray, lineWidth: 1)
                      )
                    .background( LinearGradient(gradient: Gradient(colors: [colorScheme == .dark ? .white : .yellow, colorScheme == .dark ? .blue : .red]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(15)
                    .padding(.top, 615)
                
            }.buttonStyle(PlainButtonStyle())

            .fullScreenCover(isPresented: self.$ShowAR, content: {

                FullScreenCoverContent( ShowAR: $ShowAR)
                
            })
            .padding(.top, 30)
        }
                
            }.navigationTitle ("ARWeather").foregroundColor(.black)
        .ignoresSafeArea()
    
}
    
}
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
