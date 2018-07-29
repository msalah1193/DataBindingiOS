//
//  AppDelegate.swift
//  DataBindingiOS
//
//  Created by Mohamed Salah on 7/29/18.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //setup root viewController
        let homeViewModel = DefaultHomeViewModel()
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = homeViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

