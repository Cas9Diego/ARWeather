//
//  WeatherModel.swift
//  ARWeather
//
//  Created by Diego Castro on 21/01/22.
//

import Foundation


struct WeatherModel {
    let cityName: String
    let temperature: Double
    let conditionID: Int
    
    var conditionName: String {
    switch conditionID {
    case 200...232:
        return "Thunderstorm"
    case 300...321:
        return "Drizzle"
    case 500...531:
        return "Rainy"
    case 600...622:
        return "Snow"
    case 701...710:
        return "Mist"
    case 711...720:
        return "Smoke"
    case 721...730:
        return "Haze"
    case 731...740:
        return "Dust"
    case 741...750:
        return "Fog"
    case 751...760:
        return "Sand"
    case 761...762:
        return "Dust"
    case 763...771:
        return "Squall"
    case 772...781:
        return "Tornado"
    case 800:
        return "Clear"
    case 801:
        return "Few Clouds"
    case 802:
        return "Scattered Clouds"
    case 803:
        return "Broken Clouds"
    case 804:
        return "Overcast Clouds"
    default:
        return "Clear"
        
    }
    }
    
}
