//
//  AppDelegate.swift
//  News
//
//  Created by Abdallah on 8/4/21.
//

import UIKit
import IQKeyboardManagerSwift
import Toast_Swift
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        customizeNavigationBar()
        authorizationAndPermissionNotifications()
        IQKeyboardManager.shared.enable = true

        return true
    }

    func authorizationAndPermissionNotifications(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in

            if granted {
                print("User notifications are allowed.")
            } else {
                print("User notifications are not allowed.")
            }
        }
        
    }
   
    func customizeNavigationBar(){
        let backButtonImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        UINavigationBar.appearance().backIndicatorImage = backButtonImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
    }
}

