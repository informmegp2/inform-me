//
//  AppDelegate.swift
//  InformME
//
//  Created by Amal Ibrahim on 1/28/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import UIKit

extension UILabel {
    
    var substituteFontName : String {
        get { return self.font.fontName }
        set { self.font = UIFont(name: newValue, size: self.font.pointSize) }
    }
    
}
// 1. Add the ESTBeaconManagerDelegate protocol
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ESTBeaconManagerDelegate  {
    
    var window: UIWindow?
    var barPurple = UIColor(red: (96/255.0), green: (17/255.0), blue: (143/255.0), alpha: 1.0)

    // 2. Add a property to hold the beacon manager and instantiate it
    let beaconManager = ESTBeaconManager()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // 3. Set the beacon manager's delegate
        self.beaconManager.delegate = self
        // add this below:
        self.beaconManager.requestAlwaysAuthorization()
        
        //Coloring navigationbar 
        UILabel.appearance().substituteFontName = "JFFlat-Regular"
        UINavigationBar.appearance().barTintColor = barPurple
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().setTitleVerticalPositionAdjustment(0.0, forBarMetrics: UIBarMetrics.Default)
        UINavigationBar.appearance().translucent = false
        let titleDict: NSDictionary = [NSFontAttributeName: UIFont(name: "JFFlat-Regular", size: 19)! , NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().titleTextAttributes = titleDict as? [String : AnyObject]
        return true
    }

    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

