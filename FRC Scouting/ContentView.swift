//
//  ContentView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 5/8/22.
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @EnvironmentObject var user: UserViewModel
    @ObservedObject var model = AppViewModel()
    var body: some View {
        NavigationView {
            if user.userIsAuthenticatedAndSynced || UserDefaults.standard.bool(forKey: "Logged In") {
                        TabView {
                            HomeView()
                                .tabItem {
                                    Label("Home", systemImage: "house")
                                }
                
                            PitScoutingView()
                                .tabItem{
                                    Label("Pit Scouting", systemImage: "note.text")
                                }
                
                            MatchScoutingView()
                                .tabItem {
                                    Label("Match Scouting", systemImage: "flag.2.crossed")
                                }
                            DataView()
                                .tabItem {
                                    Label("Data", systemImage: "folder")
                                }
                            
                
                        }
            } else {
                LoginView()
            }
        }
        .onAppear {
            if UserDefaults.standard.string(forKey: "Current User email") != "" {
                user.signIn(email: UserDefaults.standard.string(forKey: "Current User Email") ?? "error. Please log back in", password: UserDefaults.standard.string(forKey: "Current User Password") ?? "error. Please log back in")
            } else {
                return
            }
        }
        
       
    }
    
}
