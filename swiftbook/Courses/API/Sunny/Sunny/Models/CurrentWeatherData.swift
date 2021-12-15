//
//  CurrentWeatherData.swift
//  Sunny
//
//  Created by Евгений Карпов on 06.12.2021.
//  Copyright © 2021 Ivan Akulov. All rights reserved.
//

import Foundation

struct CurrentWeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct Weather: Codable {
    let id: Int
}
