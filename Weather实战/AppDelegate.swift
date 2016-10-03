//
//  AppDelegate.swift
//  Weather实战
//
//  Created by 樊树康 on 16/8/10.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
//

import UIKit
import RealmSwift
let realm = try! Realm()
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?

     
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        // Override point for customization after application launch.
        
        //set UI
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIView.appearance().tintColor = UIColor.whiteColor()
 

        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        if let font = UIFont(name: "Avenir-Light", size: 18.0){
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(),NSFontAttributeName:font]
            
            
        }
        //set Realm
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock:
            { migration, oldSchemaVersion in
                    
                migration.enumerate(CityRealm.className())
                { oldObject, newObject in
                   
                    if oldSchemaVersion < 1
                    {
                            
                            newObject!["pinYin"] = ""
                            newObject!["firstLetter"] = ""
                    }
                        
                }
            })
        
          return true
    }

    
    func applicationWillResignActive(application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication)
    {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication)
    {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    
    func applicationWillTerminate(application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

