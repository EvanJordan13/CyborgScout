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
    @EnvironmentObject var router: Router
   
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                        TabView (selection: $router.selectedTab) {
                            HomeView()
                                .tabItem {
                                    Label("Home", systemImage: "house")
                                }
                                .tag(0)
                
                            PitScoutingView()
                                .tabItem{
                                    Label("Pit Scouting", systemImage: "note.text")
                                }
                                .tag(1)
                
                            MatchScoutingView()
                                .tabItem {
                                    Label("Match Scouting", systemImage: "flag.2.crossed")
                                }
                                .tag(2)
                            DataView()
                                .tabItem {
                                    Label("Data", systemImage: "folder")
                                }
                                .tag(3)
                
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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
