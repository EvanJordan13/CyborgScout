//
//  DataView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 6/9/22.
//

import SwiftUI

struct DataView: View {
    
    @ObservedObject var model = AppViewModel()
    
    var body: some View {
        //        NavigationView{
        //
        //
        //
        //            //        List (model.matches) { item in
        //            //            Button {
        //            //
        //            //            } label: {
        //            //                Text("\(item.matchNumber)")
        //            //                    .foregroundColor(Color.blue)
        //            //
        //            //            }
        //            //
        //            //
        //            //        }
        //
        //
        //
        //
        //
        //            VStack {
        //
        //                List (model.robots) { item in
        //                    Text(item.teamNumber)
        //                        .swipeActions {
        //                            Button(role: .destructive) {
        //                                model.deleteRobot(robotToDelete: item)
        //                            } label: {
        //                                Label("Delete", systemImage: "trash")
        //                            }
        //
        //                        }
        //                }
        //                .refreshable {
        //                    model.getRobots()
        //                }
        //
        //                Spacer()
        //
        //                List (model.matches) { item in
        //                    Text(item.matchNumber)
        //                        .swipeActions {
        //                            Button(role: .destructive) {
        //                                model.deleteMatch(matchToDelete: item)
        //                            } label: {
        //                                Label("Delete", systemImage: "trash")
        //                            }
        //
        //                        }
        //                }
        //                //            .refreshable {
        //                //                model.getMatches()
        //                //            }
        //
        //
        //            }
        //        }
        
        
        
        
        
        
        
        
        
        //        VStack {
        //
        //            NavigationView{
        //                List {
        //                    ForEach(model.matches) { match in
        //                        Section {
        //                            NavigationLink(destination: MatchBreakdownView()) {
        //
        //
        //                                Text("Match \(match.matchNumber)")
        //                                    .navigationTitle("Matches")
        //
        //                            }
        //                        }
        //                    }
        //                }
        //                .listStyle(InsetGroupedListStyle())
        //
        //            }
        //            .navigationBarHidden(true)
        //
        //
        //
        //            NavigationView{
        //                List {
        //                    ForEach(model.robots) { robot in
        //                        Section {
        //                            NavigationLink(destination: MatchBreakdownView()) {
        //
        //
        //                                Text("Match \(robot.teamNumber)")
        //                                    .navigationTitle("Robots")
        //
        //                            }
        //                        }
        //                    }
        //                }
        //                .listStyle(InsetGroupedListStyle())
        //
        //            }
        //
        //        }
        
        NavigationView {
            
            
            List {
                //            Section(header: Text("Matches")){
                //                ForEach(model.matches) { match in
                //
                //                    MatchCardView(match: match)
                //                        .listRowBackground(match.win ? Color.blue : Color.red)
                //                        .swipeActions {
                //                            Button(role: .destructive) {
                //                                model.deleteMatch(matchToDelete: match)
                //                            } label: {
                //                                Label("Delete", systemImage: "trash")
                //                            }
                //                        }
                //
                //                }
                //            }
                
                Section(header: Text("Robots")){
                    ForEach(model.robots) { robot in
                        NavigationLink(destination: RobotSpecsView(teamNumber: robot.teamNumber)) {
                            RobotCardView(robot: robot)
                                
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                model.deleteRobot(robotToDelete: robot)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        
                    }
                }
                .navigationTitle("Data")
                
                
                
                
            }
            .refreshable {
                model.getRobots()
            }
        }
        
        
        
        
    }
    
    init() {
        model.getRobots()
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
