//
//  AppDelegate+Responder.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-02-23.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

//
// Responder Chain Demo
//

extension ResponderChainViewController: ResponderAction {
    @objc func fetchWeather(sender: Any?) {
        print("Fetching weather!")

        let alertController = UIAlertController(title: "Today's weather", message: "Cloudy with a chance of meatballs.", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in

        }))

        present(alertController, animated: true, completion: nil)
    }
}

//extension UIWindow: ResponderAction {
//    @objc func fetchWeather(sender: Any?) {
//        print("Fetching weather UIWindow!")
//    }
//}

//extension UIApplication: ResponderAction {
//    @objc func fetchWeather(sender: Any?) {
//        print("Fetching weather UIApplication!")
//    }
//}

//extension AppDelegate: ResponderAction {
//    @objc func fetchWeather(sender: Any?) {
//        print("Fetching weather AppDelegate!")
//    }
//}
