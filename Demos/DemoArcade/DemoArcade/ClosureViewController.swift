//
//  ClosureViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-02-12.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ClosureViewController: UIViewController {

    // MARK: - Controls

    let weatherButton: UIButton = {
        let button = makeButton(withText: "Fetch Weather")
        button.addTarget(self, action: #selector(weatherPressed), for: .primaryActionTriggered)
        return button
    }()

    var imageView: UIImageView = {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: "zzz", withConfiguration: configuration)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 999), for: .horizontal)

        return imageView
    }()

    let cityLabel: UILabel = {
        let label = makeLabel(withTitle: "City")
        return label
    }()

    let temperatureLabel: UILabel = {
        let label = makeLabel(withTitle: "°C")
        return label
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .white
        navigationItem.title = "Closures"

        view.addSubview(weatherButton)

        weatherButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true

        let stackView = makeRowStackView()

        view.addSubview(stackView)

        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(temperatureLabel)

        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalToSystemSpacingBelow: weatherButton.bottomAnchor, multiplier: 3).isActive = true
        stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 3).isActive = true

        cityLabel.widthAnchor.constraint(equalTo: temperatureLabel.widthAnchor).isActive = true
    }

    func updateView(with weather: ClosureWeather) {
        cityLabel.text = weather.city
        temperatureLabel.text = String(weather.temperature) + " °C"

        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: weather.imageName, withConfiguration: configuration)
        imageView.image = image
    }

    var weatherService = ClosureWeatherService()

    @objc func weatherPressed() {

        // Simple closure
        weatherService.fetchWeather(for: "San Francisco") { (weather) in
            updateView(with: weather)
        }

        // Closure with return
//        weatherService.fetchWeather(for: "New York") { (weather) -> Bool in
//            updateView(with: weather)
//            return weather.temperature < -20
//        }

        // Swift Result type
//        weatherService.fetchWeatherWithResult(for: "Seattle") { (result) in
//            switch result {
//            case .success(let weather):
//                updateView(with: weather)
//            case .failure(_):
//                print("Error 💥! ")
//            }
//        }
    }

}

struct ClosureWeatherService {
    var cacheable = false
    var weather = ClosureWeather(city: "Unknown", temperature: 0, imageName: "moon")

    mutating func fetchWeather(for city: String, completion: (ClosureWeather) -> Void) {
        weather = ClosureWeather(city: city, temperature: 21, imageName: "sunset.fill")
        completion(weather)
    }

//    mutating func fetchWeather(for city: String, completion: @escaping (ClosureWeather) -> Void) {
//        let weather = ClosureWeather(city: city, temperature: 21, imageName: "sunset.fill")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//            completion(weather) // oh oh - closure now lives longer than method > need escaping
//        })
//    }

    mutating func fetchWeather(for city: String, completion: (ClosureWeather) -> Bool) {
        if cacheable {
            cacheable = completion(weather)
            return
        }

        weather = ClosureWeather(city: city, temperature: -30, imageName: "snow")
        cacheable = completion(weather)
    }

    mutating func fetchWeatherWithResult(for city: String, completion: (Result<ClosureWeather, Error>) -> Void) {
        weather = ClosureWeather(city: city, temperature: 15, imageName: "wind")
        completion(Result.success(weather))

        // if error
        // enum WeatherError: Error { case failure }
        // completion(Swift.Result.failure(WeatherError.failure))
    }

}

struct ClosureWeather {
    typealias Celcius = Int
    let city: String
    let temperature: Celcius
    let imageName: String
}
