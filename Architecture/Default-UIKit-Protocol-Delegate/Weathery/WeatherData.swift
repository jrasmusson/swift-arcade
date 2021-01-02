//
//  WeatherData.swift
//  Weathery
//
//  Created by jrasmusson on 2020-09-01.
//  Copyright © 2020 jrasmusson. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
