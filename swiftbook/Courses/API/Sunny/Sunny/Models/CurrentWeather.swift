//
//  CurrentWeather.swift
//  Sunny
//
//  Created by Евгений Карпов on 06.12.2021.
//  Copyright © 2021 Ivan Akulov. All rights reserved.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        return "\(feelsLikeTemperature.rounded())"
    }
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sun.min.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "nosing"
            
        }
        
    }
    
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.temp
        conditionCode = currentWeatherData.weather.first!.id
    }
}
