//
//  AppDelegate.swift
//  EasyChat-iOS
//
//  Created by Nabil Kazi on 30/08/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import UIKit
import CometChatPro

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        initialiseCometChat()
        
        return true
    }
    
    private func initialiseCometChat(){
        let mySettings = AppSettings.AppSettingsBuilder().subscribePresenceForAllUsers().setRegion(region: Constants.region).build()
            
        CometChat(appId: Constants.appId ,appSettings: mySettings,onSuccess: { (isSuccess) in
            if (isSuccess) {
                print("CometChat Pro SDK intialise successfully.")
                CometChatCallManager().registerForCalls(application: self)
            }
        }) { (error) in
                print("CometChat Pro SDK failed intialise with error: \(error.errorDescription)")
        }
    }
}

