//
//  FullScreenCoverContent.swift
//  ARWeather
//
//  Created by Diego Castro on 03/03/22.
//

import SwiftUI
import RealityKit

struct FullScreenCoverContent: View {
    @State var Temp : Double = 0
    @State var cityName : String  = "London"
    @ObservedObject var weatherManager = weatherNetworkManager()
    @State var isSearchBarVisible : Bool  =  true
    @State var Condition : String = ""
    @Binding var ShowAR : Bool 
    
    var body: some View {

        ZStack {

        ARviewDisplay()
        
    VStack{
        if isSearchBarVisible {
    //Search Bar
            searchBar(cityName: $cityName, isSearchBarVisible: $isSearchBarVisible, Temp: $Temp, Condition: $Condition)
   
        }
        Spacer()

        searchToggle(isSearchToggle: $isSearchBarVisible, ShowAR: $ShowAR)
    }
    .onChange(of: cityName, perform:{ value in
        weatherManager.fetchData(cityName:cityName)})
    .onReceive(weatherManager.$receivedWeatherData, perform: { (receivedData) in

      
        if let latestData = receivedData {

            ARViewController.shared.receivedWeatherData = latestData
        }

    })

    .padding(.all)
    .animation(.default, value: isSearchBarVisible)
        
    }
        
    }
}

struct searchBar: View{
    
    @ObservedObject var weatherManager = weatherNetworkManager()
    

    
    @State var searchText : String  = ""
    @Binding var cityName : String
    @Binding var isSearchBarVisible : Bool
    //DEBUG
    @Binding var Temp : Double
    @Binding var Condition : String
    var body : some View {
        
        HStack {
       
        //Search Icon
        Image (systemName: "magnifyingglass")
            .font(.system(size: 50))
          
        
        //Search text
        TextField("Search", text: $searchText) { Value in
            //Este codigo se corre mientras el usuario escribe
            print ("Tipying in progress")
        } onCommit: {
            //Se corre cuando el usuario temrina de escribir
         
            cityName = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
         
        }

    
        }

        .frame(minHeight: 50)
        .overlay(
              RoundedRectangle(cornerRadius: 10)
                  .stroke(Color.gray, lineWidth: 2)
          )
    }
    
}


struct searchToggle: View{
    @Binding var isSearchToggle : Bool
    @Binding var ShowAR : Bool
    var body : some View {
        
        HStack (spacing: 50) {
        Button {
            isSearchToggle.toggle()
       
            
        } label: {
            Image(systemName: isSearchToggle == true ? "eye": "eye.slash")
                .font(.system(size: 50))
        }
        .animation(.default, value: isSearchToggle)
        Button {
        ShowAR = false
            
        } label: {
            Image(systemName: "arrow.down")
                .font(.system(size: 50))
        }
            Button {
                ARViewController.shared.EliminateProperties = true
                
           
                //Este boton se usa para eliminar la última de las propiedades puestas
                ARViewController.shared.oneElimination()
                
            } label: {
                Image(systemName: "arrow.counterclockwise")
                    .font(.system(size: 50))
            }
            
            
            Button {
                ARViewController.shared.EliminateAllProperties = true
                
        
                //Este boton se usa para eliminar todas las propiedades puestas
                ARViewController.shared.elimination()
                
            } label: {
                Image(systemName: "minus.circle")
                    .font(.system(size: 50))
            }
            

            
    }
    }
}


struct ARviewDisplay: View{
    var body: some View{
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        ARViewController.shared.startARSession()
        
        return   ARViewController.shared.arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

struct FullScreenCoverContent_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenCoverContent(ShowAR: .constant(false))
    }
}
