//
//  RobotSpecsView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 7/28/22.
//

import SwiftUI

struct RobotSpecsView: View {
    @ObservedObject var model = AppViewModel()
    let teamNumber: String
    
    
    
    var body: some View {
        let teamMatches = model.getTeamMatches(teamNumber: teamNumber)
        List {
            Section(header: Text("Matches")){
                ForEach(teamMatches) { match in
                    
                    MatchCardView(match: match)
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
        
    }
}


