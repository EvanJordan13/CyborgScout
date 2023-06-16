//
//  MatchDetailView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 8/2/22.
//

import SwiftUI

struct MatchDetailView: View {
    //@ObservedObject var model = AppViewModel.shared
    let match: Match
    
    //multiplies balls scored by each balls point value and returns the sum
    func getRobotScore () -> Int {
        let autoPoints = (match.autoHighGoal * 4) + (match.autoLowGoal * 2)
        let teleopPoints = (match.teleopHighGoal * 2) + (match.teleopLowGoal * 1)
        return autoPoints + teleopPoints
    }
    
    func getAutoScore () -> Int {
        return ((match.autoHighGoal * 4) + (match.autoLowGoal * 2))
    }
    
    func getTeleopScore () -> Int {
        return ((match.teleopHighGoal * 4) + (match.teleopLowGoal * 2))
    }
    
    var body: some View {
            
            Form {
                
                //General Information Card
                Section {
                    
                        HStack{
                            Text("Match Number:")
                            Spacer()
                            Text("\(match.matchNumber)")
                        }
                        
                        
                        HStack{
                            Text("Team Number:")
                            Spacer()
                            Text("\(match.teamNumber)")
                        }
                        
                        
                        HStack{
                            Text("Alliance Member 1:")
                            Spacer()
                            Text("\(match.allianceMember1)")
                        }
                        
                        
                        HStack{
                            Text("Alliance Member 2:")
                            Spacer()
                            Text("\(match.allianceMember1)")
                        }
                        
                        
                        HStack{
                            Text("Individual Robot Score:")
                            Spacer()
                            Text("\(getRobotScore())")
                        }
                        
                        
                    
                } header: {
                    Text("Overview")
                }
                
                
                
                //Autonomous card
                Section {
                    
                        HStack{
                            Text("Robot Taxied: ")
                            Spacer()
                            if match.taxied {
                                Image(systemName: "checkmark")
                                    .opacity(1.0)
                                    .foregroundColor(.blue)
                            } else {
                                Image(systemName: "xmark")
                                    .opacity(1.0)
                                    .foregroundColor(.blue)
                            }

                        }
                    
                }
                .navigationTitle("Match Details")
                
                //Scoring Card
                Section {
                
                    HStack{
                        Text("Points Scored In Auto: ")
                        Spacer()
                        Text("\(getAutoScore())")
                    }
                    
                    HStack{
                        Text("Points Scored In Teleop: ")
                        Spacer()
                        Text("\(getTeleopScore())")
                    }
                    
                    HStack{
                        Text("Robot Taxied: ")
                        Spacer()
                        if match.taxied {
                            Image(systemName: "checkmark")
                                .opacity(1.0)
                                .foregroundColor(.blue)
                        } else {
                            Image(systemName: "xmark")
                                .opacity(1.0)
                                .foregroundColor(.blue)
                        }

                    }
                    
                    HStack{
                        Text("Played Defense: ")
                        Spacer()
                        if match.playedDefense {
                            Image(systemName: "checkmark")
                                .opacity(1.0)
                                .foregroundColor(.blue)
                        } else {
                            Image(systemName: "xmark")
                                .opacity(1.0)
                                .foregroundColor(.blue)
                        }

                    }
                    
                } header: {
                    Text("Point Breakdown")
                }
                
                
                
                
            }
    }
}


