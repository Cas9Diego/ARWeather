//
//  WeatherData.swift
//  ARWeather
//
//  Created by Diego Castro on 21/01/22.
//

import Foundation

//We will define a template to get the data from the JSON struct

struct WeatherData: Codable {
    let name: String
    let weather: [Weather]
    let main: Main
}

struct Weather: Codable {
    let id: Int
}

struct Main: Codable {
    let temp: Double
}
