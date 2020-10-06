//
//  WeatherService.swift
//  Weathery
//
//  Created by jrasmusson on 2020-09-01.
//  Copyright © 2020 jrasmusson. All rights reserved.
//

import Foundation
import CoreLocation

enum ServiceError: Error {
    case network(statusCode: Int)
    case parsing
    case general(reason: String)
}

protocol WeatherServiceDelegate: AnyObject {
    func didFetchWeather(_ weatherService: WeatherService, _ weather: WeatherModel)
    func didFailWithError(_ weatherService: WeatherService, _ error: ServiceError)
}

struct WeatherService {
    var delegate: WeatherServiceDelegate?
    
    // important! update your appid here...
    let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=ce5edb27133f4b3a9eab5abfe8072942&units=metric")!
    
    func fetchWeather(cityName: String) {
        
        guard let urlEncodedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            assertionFailure("Could not encode city named: \(cityName)")
            return
        }
        
        let urlString = "\(weatherURL)&q=\(urlEncodedCityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }

    func performRequest(with urlString: String) {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            guard let unwrapedData = data,
                  let httpResponse = response as? HTTPURLResponse
            else { return }

            guard error == nil else {
                DispatchQueue.main.async {
                    let generalError = ServiceError.general(reason: "Check network availability.")
                    self.delegate?.didFailWithError(self, generalError)
                }
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    self.delegate?.didFailWithError(self, ServiceError.network(statusCode: httpResponse.statusCode))
                }
                return
            }

            guard let weather = self.parseJSON(unwrapedData) else { return }
            
            DispatchQueue.main.async {
                self.delegate?.didFetchWeather(self, weather)
            }
        }
        task.resume()
    }
    
    private func parseJSON(_ weatherData: Data) -> WeatherModel? {
        
        guard let decodedData = try? JSONDecoder().decode(WeatherData.self, from: weatherData) else {
            DispatchQueue.main.async {
                self.delegate?.didFailWithError(self, ServiceError.parsing)
            }
            return nil
        }
        
        let id = decodedData.weather[0].id
        let temp = decodedData.main.temp
        let name = decodedData.name
        
        let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
        
        return weather
    }
}
