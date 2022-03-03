//
//  WeatherNetworkManager.swift
//  ARWeather
//
//  Created by Diego Castro on 20/01/22.
//

import Foundation
import SwiftUI

public class weatherNetworkManager: ObservableObject {
    @Published var receivedWeatherData : WeatherModel? {
        didSet {
            print ("didSet")
        }
    }
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=1bb288b0c6fd7be4a30ea81afd49fce6&units=metric"
    
//    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=1bb288b0c6fd7be4a30ea81afd49fce6"
    
//    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?q="
    //Fetch data

    
    public func fetchData (cityName: String){
        
        let weatherURLString = "\(weatherURL)&q=\(cityName)"

        print ("Esto es weatherString \(weatherURLString)")

        
        //URL
        if let url = URL(string: weatherURLString) {
           
   
        //URL Session
        let session = URLSession(configuration: .default)
        //FEtching task
        let task = session.dataTask(with: url) { (data, response, error) in
            //Error handle
            
            if error != nil {
                fatalError("\(String(describing: error?.localizedDescription))")
            }
            
            //Parse JSON to a readable version
            if let receivedData = data {
                
                //Decoded
                if let decodedata = self.decodeJASONData(receivedData: receivedData){
                    //Convert to usable form
                    let weatherData = self.convertDecodedDataToUsableForm(decodedData: decodedata)
                    //Pass the data to the main view
                    self.passData(weatherData: weatherData)
                }
                
    
            }
        }
            task.resume()
            
        }
        
    }
    
    private func decodeJASONData (receivedData: Data) -> WeatherData? {
        //Write a function to decode JSON data
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: receivedData)
            //Se toma el valor almacenado en reveivedData y se pasa por el struct WeatherData
            
            return decodedData
        } catch {
            return nil
        }
      
    }
    
    private func convertDecodedDataToUsableForm (decodedData: WeatherData) -> WeatherModel {
        let weatherData = WeatherModel(cityName: decodedData.name, temperature: decodedData.main.temp, conditionID: decodedData.weather[0].id)
        
        return weatherData
    }
    
    //Pass it to the main view
    
    private func passData(weatherData: WeatherModel)  {
        receivedWeatherData = weatherData
//        return receivedWeatherData ?? []
    }
}
