//
//  AppDelegate.swift
//  VideoSlidePlay
//
//  Created by Hunter on 2020/4/14.
//  Copyright © 2020 Hunter. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        
        self.window?.rootViewController = ViewController()
        
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}

