//
//  AppDelegate.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/8/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import UIKit
import UserNotifications
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var authenToken = ""
    var studyTime : (hour : Int , minute : Int)?
    var examDate : Date?
    var isFreeVersion : Bool?
    var newlyLoggedIn = false
    var timer : Timer?
    var minutes = 0
    var profileImage : UIImage?
    
    
    
    let studyTimeKey = "studyTimeKey"
    let examDateKey = "examDateKey"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        timer = Timer.scheduledTimer(timeInterval: 60, target:self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        
        (self.window?.rootViewController as? UINavigationController)?.navigationBar.shadowImage = #imageLiteral(resourceName: "trransparent pixel image")
        
        (self.window?.rootViewController as? UINavigationController)?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "nav bar yellow"), for: UIBarMetrics.default)
        
        if let path = Bundle.main.path(forResource: "Configuration", ofType: "plist"),
            let configurationDic = NSDictionary(contentsOfFile: path){
            isFreeVersion = configurationDic["Is Free Version Type"] as? Bool
        }
        
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
//        let realm = try! Realm()
        
        
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        center.requestAuthorization(options: options) {
            (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
        return true
    }
    
    @objc func updateTime(){
        minutes += 1
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set("\(minutes)", forKey: "minutes")
        minutes = 0
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set("\(minutes)", forKey: "minutes")
    }


}

