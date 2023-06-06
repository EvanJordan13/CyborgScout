//
//  RobotSpecsView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 7/28/22.
//

import SwiftUI

struct RobotSpecsView: View {
    @ObservedObject var model = AppViewModel.shared
    let teamNumber: String
    
    
    
    var body: some View {
        let teamMatches = model.getTeamMatches(teamNumber: teamNumber)
        List {
            Section(){
                
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
            Section {
                ForEach(model.tbaTeams, id: \.self) { team in
                    Text(team.nickname)
                }
            }
        }
        .refreshable {
            model.getRobots()
        }
        
    }
}


