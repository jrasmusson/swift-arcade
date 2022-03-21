import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var rootViewController = ViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }

//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        rootViewController.sessionManager.application(app, open: url, options: options)
//        return true
//    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let parameters = rootViewController.appRemote.authorizationParameters(from: url)
        if let code = parameters?["code"] {
            rootViewController.responseTypeCode = code
        } else if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
            rootViewController.accessToken = access_token
        } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
            print("No access token error =", error_description)
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        if (rootViewController.appRemote.isConnected) {
            rootViewController.appRemote.disconnect()
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if let _ = rootViewController.appRemote.connectionParameters.accessToken {
            rootViewController.appRemote.connect()
        }
    }
}

