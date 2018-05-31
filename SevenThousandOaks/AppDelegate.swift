//
//  AppDelegate.swift
//  7000Oaks
//
//  Created by Richard Willis on 15/05/2018.
//  Copyright © 2018 Rich Text Format Ltd. All rights reserved.
//

import Filzanzug
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	
	func application (
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [ UIApplicationLaunchOptionsKey: Any ]? ) -> Bool {
		lo()
		window = UIWindow(frame: UIScreen.main.bounds)
		FZRoutingService(with: FZKeyring()).start(rootViewController: Consts.introViewController, window: window!)
		return true
	}
}
