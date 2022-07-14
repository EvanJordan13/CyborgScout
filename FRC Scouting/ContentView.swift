//
//  ContentView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 5/8/22.
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @ObservedObject var model = AppViewModel()
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
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
            viewModel.signedIn = viewModel.isSignedin
        }
       
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
