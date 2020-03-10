//
//  NotificationViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-02-24.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

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

    func setupViews() {
        navigationItem.title = "Notification Center"

        view.addSubview(weatherButton)

        weatherButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true

        let stackView = makeHorizontalStackView()

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

    func updateView(with weather: Weather) {
        cityLabel.text = weather.city
        temperatureLabel.text = weather.temperature

        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: weather.imageName, withConfiguration: configuration)
        imageView.image = image
    }

    // Notification Center

    override func viewDidLoad() {
         super.viewDidLoad()
         setupViews()

        // 2 Register
        NotificationCenter.default.addObserver(self, selector: #selector(performDidFetchWeather(_:)),
        name: Notification.Name.DidFetchWeather, object: nil) 
     }


    @objc
    func performDidFetchWeather(_ notification: Notification) { // 4 Get notified
        guard let weather = notification.userInfo?["weather"] as? Weather else {
          return
        }

        updateView(with: weather) // 5 Update view
    }

    @objc
    func weatherPressed() {
        let weatherService = NotificationWeatherService()
        weatherService.fetchWeather()
    }
}


extension Notification.Name { // 1 Define notification
     static let DidFetchWeather = Notification.Name("DidFetchWeather")
}

struct NotificationWeatherService {

    func fetchWeather() {
        let weather = Weather(city: "San Francisco", temperature: "21 °C", imageName: "sunset.fill")
        let userInfo = ["weather": weather] // 3 Fetch & Post
        NotificationCenter.default.post(name: .DidFetchWeather, object: nil, userInfo: userInfo)
    }

}
