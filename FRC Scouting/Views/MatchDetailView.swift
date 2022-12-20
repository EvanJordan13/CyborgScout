//
//  MatchDetailView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 8/2/22.
//

import SwiftUI
import SwiftUICharts

struct MatchDetailView: View {
    @ObservedObject var model = AppViewModel()
    let match: Match
    
    //multiplies balls scored by each balls point value and returns the sum
    func getRobotScore () -> Double {
        let autoPoints = (match.autoHighGoal * 4) + (match.autoLowGoal * 2)
        let teleopPoints = (match.teleopHighGoal * 2) + (match.teleopLowGoal * 1)
        return autoPoints + teleopPoints
    }
    
    var body: some View {
        let autoHigh = Legend(color: .blue, label: "Autonomous High Goal")
        let autoLow = Legend(color: .red, label: "Autonomous Low Goal")
        let teleopHigh = Legend(color: .orange, label: "Teleoperated High Goal")
        let teleopLow = Legend(color: .pink, label: "Teleoperated Low Goal")
        
        let totalPoints: [DataPoint] = [
            .init(value: match.autoHighGoal, label: "\(Int(match.autoHighGoal))", legend: autoHigh),
            .init(value: match.autoLowGoal, label: "\(Int(match.autoLowGoal))", legend: autoLow),
            .init(value: match.teleopHighGoal, label: "\(Int(match.teleopHighGoal))", legend: teleopHigh),
            .init(value: match.teleopLowGoal, label: "\(Int(match.teleopLowGoal))", legend: teleopLow)
        ]
        
       
            
            List {
                
                //General Information Card
                Section {
                    VStack{
                        HStack{
                            Text("Match Number:")
                            Spacer()
                            Text("\(match.matchNumber)")
                        }
                        .padding()
                        
                        Spacer()
                        
                        HStack{
                            Text("Team Number:")
                            Spacer()
                            Text("\(match.teamNumber)")
                        }
                        .padding()
                        
                        HStack{
                            Text("Alliance Member 1:")
                            Spacer()
                            Text("\(match.allianceMember1)")
                        }
                        .padding()
                        
                        HStack{
                            Text("Alliance Member 2:")
                            Spacer()
                            Text("\(match.allianceMember1)")
                        }
                        .padding()
                        
                        HStack{
                            Text("Individual Robot Score:")
                            Spacer()
                            Text("\(getRobotScore())")
                        }
                        .padding()
                        
                    }
                }
                
                
                //Autonomous card
                Section {
                    VStack {
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
                }
                .navigationTitle("Match Details")
                
                //Scoring Card
                Section {
                    BarChartView(dataPoints: totalPoints)
                        .padding()
                } header: {
                    Text("Point Breakdown")
                }
                
                
                
                
            }
        
        
    }
}


