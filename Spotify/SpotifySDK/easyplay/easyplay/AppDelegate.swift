//
//  AppDelegate.swift
//  easyplay
//
//  Created by jrasmusson on 2022-03-20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let SpotifyClientID = "5198668b9cfb4947a03598940c9b3a1c"
    let SpotifyRedirectURL = URL(string: "easyplay://")!

    var accessToken = ""

    lazy var configuration = SPTConfiguration(clientID: SpotifyClientID, redirectURL: SpotifyRedirectURL)

    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
        appRemote.connectionParameters.accessToken = self.accessToken
        appRemote.delegate = self
        return appRemote
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground

        let navigationController = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = navigationController

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let parameters = appRemote.authorizationParameters(from: url)

        if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
            appRemote.connectionParameters.accessToken = access_token
            self.accessToken = access_token
        } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
            print("foo - \(error_description)")
        }

        return true
    }
}

extension AppDelegate: SPTAppRemoteDelegate {

    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("foo - connected")
    }

    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("foo - connection failed: \(error)")
    }

    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("foo - disconnect: \(error)")
    }
}

extension AppDelegate: SPTAppRemotePlayerStateDelegate {
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        print("foo - state changed")
    }
}

