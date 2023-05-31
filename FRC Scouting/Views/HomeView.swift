//
//  HomeView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 6/9/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject public  var viewModel: AppViewModel
    @EnvironmentObject var user: UserViewModel
    @Binding var tabSelection: Int
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                
                Section {
                    Button(action: { self.tabSelection = 1}) {
                        HStack {
                                HStack{
                                    Label("", systemImage: "list.bullet.clipboard")
                                    Text("Scout A New Robot")
                                        .font(.headline)
                                        .accessibilityAddTraits(.isHeader)
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
                    Button(action: { self.tabSelection = 2}) {
                        HStack {
                            HStack {
                                Label("", systemImage: "flag.2.crossed")
                                Text("Scout A New Match")
                                    .font(.headline)
                                    .accessibilityAddTraits(.isHeader)
                                
                            }
                            .padding()
                            .foregroundColor(.primary)
                            Spacer()
                            Label("", systemImage: "chevron.right")
                        }
                    }
                    }
                
                
                Section {
                    Button(action: { self.tabSelection = 3}) {
                        HStack{
                            HStack {
                                Label("", systemImage: "folder")
                                Text("View Scouted Robots")
                                    .font(.headline)
                                    .accessibilityAddTraits(.isHeader)
                                
                            }
                            .padding()
                            .foregroundColor(.primary)
                            Spacer()
                            Label("", systemImage: "chevron.right")
                        }
                    }
                    }
                
                Section {
                    
                    ZStack{
                        NavigationLink(destination: RankingsView()) {
                        }
                        .opacity(0.0)
                        .buttonStyle(PlainButtonStyle())
                        HStack{
                            HStack {
                                Label("", systemImage: "trophy")
                                VStack{
                                    Text("View Rankings")
                                        .font(.headline)
                                        .accessibilityAddTraits(.isHeader)
                                }
                            }
                            .padding()
                            .foregroundColor(.primary)
                            Spacer()
                            Label("", systemImage: "chevron.right")
                        }
                    }
                }
                    
                
                
                
                Section {
                    
                    ZStack{
                        NavigationLink(destination: AccountView()) {
                        }
                        .opacity(0.0)
                        .buttonStyle(PlainButtonStyle())
                        HStack{
                            HStack {
                                Label("", systemImage: "person")
                                VStack{
                                    Text("View Account")
                                        .font(.headline)
                                        .accessibilityAddTraits(.isHeader)
                                    Text("Logged In As: \(user.user?.username ?? "")")
                                        .font(.caption)
                                }
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
        
        .onAppear {
            viewModel.storeAllAverageScores()
        }
        
    }
}

