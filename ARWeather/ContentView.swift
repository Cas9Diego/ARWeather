//
//  ContentView.swift
//  ARWeather
//
//  Created by Diego Castro on 20/01/22.
//

import ARKit
import RealityKit
import SwiftUI

class shared: ObservableObject {
    @Published var showBodies: Bool = false
}

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    let Colors = Color(red: 0.898, green: 0.898, blue: 0.898)
    let Colors2 = Color(red: 0, green: 45, blue: 131)
    var models = ["1", "2", "3", "4"]
    @State var modelIndex = 1
    @State var ShowAR : Bool  =  false
    @ObservedObject var weatherManager = weatherNetworkManager()
    @State var selectedSizes = ARViewController.shared.selectedSize
    @StateObject var seeBodyOptions = shared()
    
    
    
    func roundedRectangleFilled (cornerRadious: Double, width: Double, height: Double, color: Color, alignment: Alignment ) -> some View {
        return RoundedRectangle(cornerRadius: cornerRadious, style: .continuous)
            .fill(color)
            .frame(width: width,
                   height: height,
                   alignment: alignment)
        
    }
    
    func roundedRectangleStroke (cornerRadious: Double, width: Double, height: Double, strokeColor: Color, lineWidth: Double, alignment: Alignment ) -> some View {
        return RoundedRectangle(cornerRadius: cornerRadious, style: .continuous)
            .strokeBorder(strokeColor, lineWidth: lineWidth)
            .frame(width: width,
                   height: height,
                   alignment: alignment)
        
    }
    var body: some View {
        
        NavigationView {
            
            ZStack{
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
            
                VStack(spacing: 60){
                     
                    Button {
                        seeBodyOptions.showBodies.toggle()
                    } label: {
                        ZStack {
                            roundedRectangleStroke(cornerRadious: 25, width: UIScreen.main.bounds.width*(9/10), height: UIScreen.main.bounds.height*(2/4), strokeColor: Color(UIColor.lightGray), lineWidth: 8, alignment: .center)
                            
                            if colorScheme == .dark{
                                ZStack {
                                Image(uiImage: UIImage(named: models[modelIndex])!)
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width*(2.8/5), height: UIScreen.main.bounds.height*(1.8/5))
                                    .cornerRadius(15)
                                }  .opacity(0.3)

                            } else {
                                ZStack {
                                    ZStack {
                            Image(uiImage: UIImage(named: models[modelIndex])!)
                                    .resizable()
                                
                                    .frame(width: UIScreen.main.bounds.width*(2.8/5), height: UIScreen.main.bounds.height*(1.8/5))
                                    
                                    } .opacity(0.2)
                                    .frame(width: UIScreen.main.bounds.width*(3.3/5), height: UIScreen.main.bounds.height*(1.9/5))
                                }
                            }
                            VStack {
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width*1/12,
                                           alignment: .center)
                                    .foregroundColor(Color(UIColor.blue))
                                
                                Text ("Choose a 3D Body ")
                                    .font(.custom("Arial", size: 20))
                                    .foregroundColor(Color(UIColor.blue))
                            }
                            
                            
                            
                        }
                    }
         
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
                
            }.buttonStyle(PlainButtonStyle())

            .fullScreenCover(isPresented: self.$ShowAR, content: {

                FullScreenCoverContent( ShowAR: $ShowAR)
                
            })
   
                
            }
            }.navigationTitle ("ARWeather").foregroundColor(.black)
                .sheet(isPresented: $seeBodyOptions.showBodies) {
                    
                    ScrollContentView( bodyOptions: $seeBodyOptions.showBodies, modelIndex: $modelIndex)
                }
    
        }
}
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
