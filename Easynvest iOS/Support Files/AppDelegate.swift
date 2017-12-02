//
//  AppDelegate.swift
//  Easynvest iOS
//
//  Created by Bruno Pereira dos Santos on 01/12/2017.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupInitialViewController()
        return true
    }

    /// Initialize the main navigation controller and the first view controller
    func setupInitialViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let simulateViewController = SimulateViewController()
        let navigationController = UINavigationController(rootViewController: simulateViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
