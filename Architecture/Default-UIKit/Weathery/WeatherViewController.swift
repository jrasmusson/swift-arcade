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
        
        weatherService.delegate = self
        weatherView.searchTextFieldHandler = fetchWeather(_:)
        weatherView.locationButtonHandler = requestLocation
    }
    
    func style() {
        weatherView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(weatherView)
       
        // Two options for displaying view in viewController
        
        //  1. Set to view (full screen take over).
        view = weatherView
                
        //  2. AutoLayout (manually layout)
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: view.topAnchor),
            weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherServiceDelegate {

    func didFetchWeather(_ weatherService: WeatherService, weather: WeatherModel) {
        weatherView.weather = weather
    }

    func didFailWithError(_ weatherService: WeatherService, _ error: ServiceError) {
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
