//
//  ScrollView.swift
//  ARWeather
//
//  Created by Diego Castro on 03/03/22.
//

import SwiftUI

struct ScrollContentView: View {
    var models = ["1", "2", "3", "4"]
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ScrollView(){
            VStack(spacing: 30){
                ForEach(0...1, id: \.self){ index in
                    Button{
                        ARViewController.shared.selectedModel = index
                    } label: {
                        if colorScheme == .dark{
                            Image(uiImage: UIImage(named: models[index+2])!)
                                .resizable()
                            //Se usa reszable porque en swiftui las imagenes no son modificables por default
                                .frame(width: 220, height: 220)

                                .cornerRadius(15)

                        } else {
                        Image(uiImage: UIImage(named: models[index])!)
                                .resizable()
                            //Se usa resizable porque en swiftui las imagenes no son modificables por default
                                .frame(width: 220, height: 220)

                                .cornerRadius(15)

                        }
                        
                    }
                 
                    .buttonStyle(PlainButtonStyle())

                }
            
            }

        
        }
   
        .padding(.top, 240)
        
    }
}

struct ScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollContentView()
    }
}
