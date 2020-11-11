//
//  AppDelegate.swift
//  BugReporting
//
//  Created by DaniArnaout on 04/19/2020.
//  Copyright (c) 2020 DaniArnaout. All rights reserved.
//

import UIKit
import BugReporting

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		BugReporting.shared.enabled = true
		return true
	}
}
