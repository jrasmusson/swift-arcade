//
//  AppDelegate.swift
//  StarbucksResponderChain
//
//  Created by jrasmusson on 2020-12-12.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let mainViewController = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.makeKeyAndVisible()
            window?.backgroundColor = .systemBackground
                    
            window?.rootViewController = mainViewController
            
            return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        /*
         starbucks://home
         starbucks://scan
         */
    
        // Process the URL.
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
              let host = components.host else {
            print("Invalid URL")
            return false
        }
                
        print("components: \(components)")
        
        guard let deeplink = DeepLink(rawValue: host) else {
            print("Deeplink not found: \(host)")
            return false
        }

        // Pass deeplink to MainViewController to handle
        mainViewController.handleDeepLink(deeplink)
        
        return true
    }
}
