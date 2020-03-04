//
//  KVOViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-02-23.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class KVOViewController: UIViewController {

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

    func updateView(with weather: KVOWeather) {
        cityLabel.text = weather.city
        temperatureLabel.text = weather.temperature

        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: weather.imageName, withConfiguration: configuration)
        imageView.image = image
    }

    @objc func weatherPressed() {
        weatherService.fetchWeather(for: "San Francisco")
    }
    
    /// KVO
    var observableWeather: Any?
    @objc let weatherService = KVOWeatherService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        // 2 Observe it
        observableWeather = weatherService.observe(\.weather, options: [.initial, .new]) {
            // 5 Get updated
            [unowned self] object, change in
            let weatherValue = change.newValue
            self.updateView(with: weatherValue!)
        }
    }
}

@objc
class KVOWeatherService: NSObject {

    // 1 Make weather observable
    //   - `dynamic` bridges objc and Swift. Use to enable Key-Value observing.
    @objc dynamic var weather = KVOWeather(city: "Unknown", temperature: "X °C", imageName: "moon")

    func fetchWeather(for city: String) {
        weather = KVOWeather(city: city, temperature: "21 °C", imageName: "sunset.fill")
    }

}

@objc
class KVOWeather: NSObject {
    var city: String
    var temperature: String!
    var imageName: String!
    
    init(city: String, temperature: String, imageName: String) {
        self.city = city
        self.temperature = temperature
        self.imageName = imageName
    }
}

// 1. Property must be representable in objc (so no Swift structs, enums)
// 2. Weather Service must also be represented in objc (@objc for class, extend NSObject)

/*
 
 Things you needed to do:
 - Make KVOWeather class, @objc, NSObject
 - Make KVOWeatherService class, @objc, NSObject
 - Get rid of closure (no longer required as we are observing)
 - Make weather observable (@objc dynamic var)
 
 Note the following:
 - no closure or call back needed
 - the Swifter way to do this is with Swift property observers (willSet/didSet)
 
 Difference between property observers (willSet and didSet)?
 You can add observers outside the type definition.
 
 */


