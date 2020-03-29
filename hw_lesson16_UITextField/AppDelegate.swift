//
//  AppDelegate.swift
//  hw_lesson16_UITextField
//
//  Created by Олег Чудновский on 22.03.2020.
//  Copyright © 2020 Олег Чудновский. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // set eng locality
        UserDefaults.standard.set(["en"], forKey: "AppleLanguages")

        return true
    }

}

