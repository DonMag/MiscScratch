//
//  AppDelegate.swift
//  Scroll9
//
//  Created by Don Mag on 7/20/20.
//  Copyright © 2020 DonMag. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		if #available(iOS 13.0, *) {
			
			let newNavBarAppearance = createBarButtonAppearence(.blue, textColor: .yellow)

			let appearance = UINavigationBar.appearance()
			appearance.scrollEdgeAppearance = newNavBarAppearance
			appearance.compactAppearance = newNavBarAppearance
			appearance.standardAppearance = newNavBarAppearance
			if #available(iOS 15.0, *) {
				appearance.compactScrollEdgeAppearance = newNavBarAppearance
			}

//			let newNavBarAppearance = customNavBarAppearance()
//
//			let back = UIBarButtonItemAppearance()
////			back.normal.backgroundImage = UIImage(systemName: "chevron.backward.2")
////			newNavBarAppearance.backButtonAppearance = back
//
//			let appearance = UINavigationBar.appearance()
//
////			if let img = UIImage(systemName: "chevron.backward.2") {
////				newNavBarAppearance.setBackIndicatorImage(img, transitionMaskImage: img)
////			}
//
//			appearance.scrollEdgeAppearance = newNavBarAppearance
//			appearance.compactAppearance = newNavBarAppearance
//			appearance.standardAppearance = newNavBarAppearance
//			if #available(iOS 15.0, *) {
//				appearance.compactScrollEdgeAppearance = newNavBarAppearance
//			}
//

		} else {
			// Fallback on earlier versions
		}

		return true
	}

	@available(iOS 13.0, *)
	private func createBarButtonAppearence(_ color: UIColor, textColor: UIColor)  -> UINavigationBarAppearance {
		let appearance = UINavigationBarAppearance()
		appearance.titleTextAttributes = [.foregroundColor: textColor]
		appearance.largeTitleTextAttributes = [.foregroundColor: textColor]
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = color
		
		// do this
		if let img = UIImage(systemName: "chevron.up.circle") {
			appearance.setBackIndicatorImage(img, transitionMaskImage: img)
		}

		// don't do this:
		//let back = UIBarButtonItemAppearance()
		//back.normal.backgroundImage = UIImage(named: "white_back_arrow")
		//appearance.backButtonAppearance = back
		
		return appearance
	}
	
	@available(iOS 13.0, *)
	func customNavBarAppearance() -> UINavigationBarAppearance {
		let customNavBarAppearance = UINavigationBarAppearance()
		
		// Apply a red background.
		customNavBarAppearance.configureWithOpaqueBackground()
		customNavBarAppearance.backgroundColor = .systemRed
		
		// Apply white colored normal and large titles.
		customNavBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
		customNavBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
		
		if let img = UIImage(systemName: "chevron.up.circle") {
			customNavBarAppearance.setBackIndicatorImage(img, transitionMaskImage: img)
		}

		// Apply white color to all the nav bar buttons.
//		let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
//		barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
//		barButtonItemAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.lightText]
//		barButtonItemAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.label]
//		barButtonItemAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.white]
//		customNavBarAppearance.buttonAppearance = barButtonItemAppearance
//		customNavBarAppearance.backButtonAppearance = barButtonItemAppearance
//		customNavBarAppearance.doneButtonAppearance = barButtonItemAppearance
		
		return customNavBarAppearance
	}
	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

