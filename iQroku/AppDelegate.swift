//
//  AppDelegate.swift
//  iQroku
//
//  Created by NDS on 02/08/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupBackButtonBar()
        
//        IqrokuDB.instance.createTableConfig()
//        if IqrokuDB.instance.insert(withQuery: "INSERT INTO config (key, value) VALUES ('iq1','10'),('iq2','0'),('iq3','0'),('iq4','0'),('iq5','0'),('iq6','5')") {
//            print("Insert config data success")
//        }
        
//        if IqrokuDB.instance.dropTable(withTable: "config") {
//            print("Drop table success")
//        }
//        if IqrokuDB.instance.update(withQuery: "TRUNCATE TABLE iqro") {
//            IqrokuDB.instance.insertIqroData()
//        }
//
//        if IqrokuDB.instance.update(withQuery: "UPDATE iqro set done = 'N'") {
//            print("Update data iqro finish")
//        }
        return true
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
        // Saves changes in the application's managed object context before the application terminates.
    }
    
    func setupBackButtonBar() {
        let backImage = UIImage(named: "img-home")!.withRenderingMode(.alwaysOriginal)
        UINavigationBar.appearance().backIndicatorImage = backImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for: .default)
    }

}
