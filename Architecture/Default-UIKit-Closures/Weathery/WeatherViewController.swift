//
//  ViewController.swift
//  Weathery
//
//  Created by jrasmusson on 2020-08-28.
//  Copyright © 2020 jrasmusson. All rights reserved.
//

import UIKit
import CoreLocation

private struct LocalSpacing {
    static let buttonSizeSmall = CGFloat(40)
    static let buttonSizelarge = CGFloat(120)
}

class WeatherViewController: UIViewController {
    
    var weatherService = WeatherService()
    let locationManager = CLLocationManager()
    
    let weatherView = WeatherView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

extension WeatherViewController {
    
    func setup() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherView.searchTextFieldHandler = fetchWeather(_:)
        weatherView.locationButtonHandler = requestLocation
        weatherService.resultHandler = didFetchWeather(_:)
    }
    
    func style() {
        weatherView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(weatherView)
        view = weatherView
    }
}

// MARK: - Callbacks

extension WeatherViewController {

    func fetchWeather(_ textField: UITextField) {
        if let city = textField.text {
            weatherService.fetchWeather(cityName: city)
        }
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
}

// MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherService.fetchWeather(latitude: lat, longitude: lon)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - Update UI

extension WeatherViewController {
    
    func didFetchWeather(_ result: Result<WeatherModel, ServiceError>) {
        switch result {
        
        case .success(let weather   ):
            weatherView.weather = weather
        case .failure(let error):
            showError(error)
        }
    }
 
    func showError(_ error: ServiceError) {
        let message: String

        switch error {
        case .network(statusCode: let statusCode):
            message = "Networking error. Status code: \(statusCode)."
        case .parsing:
            message = "JSON weather data could not be parsed."
        case .general(reason: let reason):
            message = reason
        }
        showErrorAlert(with: message)
    }
    
    func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Error fetching weather",
                                      message: message,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)
    }
}
