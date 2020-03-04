//
//  PropertyObserverViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-02-23.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class PropertyObserverViewController: UIViewController {
    
   override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
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
        view.backgroundColor = .white
        navigationItem.title = "KVO"
        
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
    
    // Property observer
    
    var weather: Weather = Weather(city: "Unknown", temperature: "X °C", imageName: "moon") {
        willSet {
            print("About to set the weather to: \(newValue)")
        }
        
        didSet {
            updateView(with: self.weather)
        }
    }
    
    @objc func weatherPressed() {
        fetchWeather(for: "San Francisco")
    }
    
    func fetchWeather(for city: String) {
        weather = Weather(city: city, temperature: "21 °C", imageName: "sunset.fill")
    }
}

