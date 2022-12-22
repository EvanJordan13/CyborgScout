//
//  HomeView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 6/9/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject public  var viewModel: AppViewModel
    
    
    var body: some View {
        
        NavigationView {
            
            
            List {
                
                Section {
                    Button(action: { Router.shared.selectedTab = 1}) {
                        
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Scout A New Robot")
                                    .font(.headline)
                                    .accessibilityAddTraits(.isHeader)
                                Spacer()
                                HStack {
                                    Label("Teams Scouted: \(viewModel.getNumRobots())", systemImage: "note.text")
                                }
                                .font(.caption)
                            }
                            .navigationTitle("Cyborg Scout")
                            .padding()
                            .foregroundColor(.primary)
                            Spacer()
                            Label("", systemImage: "chevron.right")
                        }
                    }
                }
                
                
                Section {
                    Button(action: { Router.shared.selectedTab = 2}) {
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Scout A New Match")
                                    .font(.headline)
                                    .accessibilityAddTraits(.isHeader)
                                Spacer()
                                HStack {
                                    Label("Matches Scouted: \(viewModel.getNumMatches())", systemImage: "flag.2.crossed")
                                }
                                .font(.caption)
                            }
                            .padding()
                            .foregroundColor(.primary)
                            Spacer()
                            Label("", systemImage: "chevron.right")
                        }
                    }
                }
                
                Section {
                    Button(action: { Router.shared.selectedTab = 3}) {
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("View Scouted Robots And Matches")
                                    .font(.headline)
                                    .accessibilityAddTraits(.isHeader)
                                Spacer()
                                HStack {
                                    Label("Teams Scouted: \(viewModel.getNumRobots())", systemImage: "folder")
                                }
                                .font(.caption)
                            }
                            .padding()
                            .foregroundColor(.primary)
                            Spacer()
                            Label("", systemImage: "chevron.right")
                        }
                    }
                    
                }
                
                Section {
                    NavigationLink(destination: AccountView()) {
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("View Account")
                                    .font(.headline)
                                    .accessibilityAddTraits(.isHeader)
                                Spacer()
                                HStack {
                                    Label("Logged In As: \(viewModel.getNumRobots())", systemImage: "person")
                                }
                                .font(.caption)
                            }
                            .padding()
                            .foregroundColor(.primary)
                            Spacer()
                            Label("", systemImage: "chevron.right")
                        }
                    }
                    
                }
                
                
            }
        }
    }
}
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}

