//
//  ProtocolWeatherService.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-02-03.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate: AnyObject {
    func didFetchWeather(_ weather: Weather)
}









class WeatherService {







    weak var delegate: WeatherServiceDelegate?

    func fetchWeather() {
        let weather = Weather(city: "San Francisco", temperature: "21 °C", imageName: "sunset.fill")
        delegate?.didFetchWeather(weather) // 4
    }
}
