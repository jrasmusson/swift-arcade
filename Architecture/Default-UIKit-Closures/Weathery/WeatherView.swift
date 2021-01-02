//
//  WeatherView.swift
//  Weathery
//
//  Created by jrasmusson on 2021-01-01.
//  Copyright © 2021 jrasmusson. All rights reserved.
//

import UIKit
import CoreLocation

private struct LocalSpacing {
    static let buttonSizeSmall = CGFloat(40)
    static let buttonSizelarge = CGFloat(120)
}

class WeatherView: UIView {

    let rootStackView = UIStackView()
    
    // search
    let searchStackView = UIStackView()
    let locationButton = UIButton()
    let searchTextField = UITextField()
    let searchButton = UIButton()
    
    // weather
    let conditionImageView = UIImageView()
    let temperatureLabel = UILabel()
    let cityLabel = UILabel()

    // background
    let backgroundView = UIImageView()
    
    // callbacks
    var searchTextFieldHandler: ((UITextField) -> Void)?
    var locationButtonHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Data
    
    var weather: WeatherModel? {
        didSet {
            guard let weather = weather else { return }
            temperatureLabel.attributedText = makeTemperatureText(with: weather.temperatureString)
            conditionImageView.image = UIImage(systemName: weather.conditionName)
            cityLabel.text = weather.cityName
        }
    }
}

extension WeatherView {
    
    func setup() {
        searchTextField.delegate = self
    }
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.axis = .vertical
        rootStackView.alignment = .trailing
        rootStackView.spacing = 10

        // search
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        searchStackView.spacing = 8
                
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        locationButton.addTarget(self, action: #selector(locationPressed(_:)), for: .primaryActionTriggered)
        locationButton.tintColor = .label
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.font = UIFont.preferredFont(forTextStyle: .title1)
        searchTextField.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        searchTextField.placeholder = "Search"
        searchTextField.textAlignment = .right
        searchTextField.borderStyle = .roundedRect
        searchTextField.backgroundColor = .systemFill
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchPressed(_:)), for: .primaryActionTriggered)
        searchButton.tintColor = .label

        // weather
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        conditionImageView.image = UIImage(systemName: "sun.max")
        conditionImageView.tintColor = .label
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.font = UIFont.systemFont(ofSize: 80)
        temperatureLabel.attributedText = makeTemperatureText(with: "21")
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        cityLabel.text = "Cupertino"

        // background
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.image = UIImage(named: "background")
        backgroundView.contentMode = .scaleAspectFill
    }
    
    func layout() {
        searchStackView.addArrangedSubview(locationButton)
        searchStackView.addArrangedSubview(searchTextField)
        searchStackView.addArrangedSubview(searchButton)
        
        rootStackView.addArrangedSubview(searchStackView)
        rootStackView.addArrangedSubview(conditionImageView)
        rootStackView.addArrangedSubview(temperatureLabel)
        rootStackView.addArrangedSubview(cityLabel)
        
        addSubview(backgroundView)
        addSubview(rootStackView)
       
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            rootStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: rootStackView.trailingAnchor, multiplier: 1),
            
            searchStackView.leadingAnchor.constraint(equalTo: rootStackView.leadingAnchor),
            searchStackView.trailingAnchor.constraint(equalTo: rootStackView.trailingAnchor),
            
            locationButton.heightAnchor.constraint(equalToConstant: LocalSpacing.buttonSizeSmall),
            locationButton.widthAnchor.constraint(equalToConstant: LocalSpacing.buttonSizeSmall),
            
            searchButton.heightAnchor.constraint(equalToConstant: LocalSpacing.buttonSizeSmall),
            searchButton.widthAnchor.constraint(equalToConstant: LocalSpacing.buttonSizeSmall),
            
            conditionImageView.heightAnchor.constraint(equalToConstant: LocalSpacing.buttonSizelarge),
            conditionImageView.widthAnchor.constraint(equalToConstant: LocalSpacing.buttonSizelarge),

            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

// MARK: - Factories

extension WeatherView {
    private func makeTemperatureText(with temperature: String) -> NSAttributedString {
        
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.label
        boldTextAttributes[.font] = UIFont.boldSystemFont(ofSize: 100)

        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font] = UIFont.systemFont(ofSize: 80)

        let text = NSMutableAttributedString(string: temperature, attributes: boldTextAttributes)
        text.append(NSAttributedString(string: "°C", attributes: plainTextAttributes))

        return text
    }
}

// MARK: - UITextFieldDelegate

extension WeatherView: UITextFieldDelegate {
    
    @objc func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let handler = searchTextFieldHandler else { return }
        
        handler(textField)
        searchTextField.text = ""
    }
}

// MARK: - Actions

extension WeatherView {
        
    @objc func locationPressed(_ sender: UIButton) {
        guard let handler = locationButtonHandler else { return }

        handler()
    }
}
