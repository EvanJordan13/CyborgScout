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
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
