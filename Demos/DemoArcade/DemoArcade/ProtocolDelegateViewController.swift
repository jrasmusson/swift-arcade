//
//  ProtocolWeatherViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-02-02.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

extension ProtocolDelegateViewController: WeatherServiceDelegate {
    func didFetchWeather(_ weather: Weather) { // 5
        cityLabel.text = weather.city
        temperatureLabel.text = weather.temperature

        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: weather.imageName, withConfiguration: configuration)
        imageView.image = image
    }
}

extension ProtocolDelegateViewController: WeatherServiceDataSource {
    var city: String? {
        let _city: String? = "San Francisco"
        return _city
    }
}

class ProtocolDelegateViewController: UIViewController {
    let weatherService = WeatherService() // 1

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        weatherService.delegate = self // 2
        weatherService.dataSource = self
    }

    @objc func weatherPressed() {
        weatherService.fetchWeather() // 3
    }
    
    // MARK: - Controls

    let weatherButton: UIButton = {
        let button = makeButton(withText: "Fetch Weather")
        button.addTarget(self, action: #selector(weatherPressed), for: .touchDown)
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
        view.backgroundColor = .white
        navigationItem.title = "Protocol Delegate"

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
}
