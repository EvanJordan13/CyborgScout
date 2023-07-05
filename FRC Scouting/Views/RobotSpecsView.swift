//
//  RobotSpecsView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 7/28/22.
//

import SwiftUI

struct RobotSpecsView: View {
    @StateObject var model = AppViewModel.shared
    @StateObject var robotDataModel = RobotDataViewModel.shared
    let teamNumber: String
    
    //Error is possibly in model singleton made in appviewmodel
    //Error is persisting despite removing appviewmodel singleton
    var body: some View {
        
        let teamMatches = model.getTeamMatches(teamNumber: robotDataModel.teamNumber)
        List {
            Section() {
                
                if teamMatches.count == 0 {
                    Text("No Matches Scouted")
                } else {
                    
                    ForEach(teamMatches) { match in
                        NavigationLink(destination: MatchDetailView(match: match)) {
                            
                            MatchCardView(match: match)

                        }
                        
                        .listRowBackground(match.win ? Color.blue : Color.red)
                        .swipeActions {
                            Button(role: .destructive) {
                                model.deleteMatch(matchToDelete: match)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Matches")

        }
        .onAppear {
            robotDataModel.setCurrentTeamNumber(teamNumber: self.teamNumber)
        }
        
        .refreshable {
            model.getRobots()
        }
        
    }
}


