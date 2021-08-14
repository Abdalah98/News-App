//
//  UIApplaction+Ext.swift
//  News
//
//  Created by Abdallah on 8/12/21.
//

import Foundation

import UIKit
extension UIApplication {
    static func mainTabaBarController()-> MainTabBarController?{
        return shared.windows.filter { $0.isKeyWindow }.first?.rootViewController as? MainTabBarController

    }
}
