//
//  FRC_ScoutingApp.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 5/8/22.
//

import SwiftUI
import Firebase

@main
struct FRC_ScoutingApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            
            
            ContentView()
            
                
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
    
    
    
}
