//
//  AppDelegate.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/19.
//  Copyright © 2019 adriana. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let loginController = LoginViewController(name: nil)
        let navigationController = UINavigationController(rootViewController: loginController)
        navigationController.isNavigationBarHidden = true
        AppNavigationHelper.sharedInstance.navigationController = navigationController
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        //Fb SDK
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return ApplicationDelegate.shared.application(app, open: url, options: options)
    }
    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
}
