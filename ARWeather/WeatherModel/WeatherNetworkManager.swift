//
//  WeatherNetworkManager.swift
//  ARWeather
//
//  Created by Diego Castro on 20/01/22.
//

import Foundation
import SwiftUI

public class weatherNetworkManager: ObservableObject {
    @Published var receivedWeatherData : WeatherModel?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(ApiKey().apiKey())&units=metric"
    
    public func fetchData (cityName: String){
        
        let weatherURLString = "\(weatherURL)&q=\(cityName)"
        
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
    }
}
