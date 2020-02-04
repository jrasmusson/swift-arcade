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









protocol WeatherServiceDataSource: AnyObject {
    var city: String? { get }
}




class WeatherService {







    weak var delegate: WeatherServiceDelegate?
    weak var dataSource: WeatherServiceDataSource?

    func fetchWeather() {
        guard let dataSource = dataSource, let city = dataSource.city else {
            assertionFailure("DataSource not set")
            return
        }
        let weather = Weather(city: city, temperature: "21 °C", imageName: "sunset.fill")
        delegate?.didFetchWeather(weather) // 4
    }
}
