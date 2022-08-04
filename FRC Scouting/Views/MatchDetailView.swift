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
    
    var body: some View {
        let autoHigh = Legend(color: .blue, label: "Autonomous High Goal")
        let autoLow = Legend(color: .red, label: "Autonomous Low Goal")
        let teleopHigh = Legend(color: .orange, label: "Teleoperated High Goal")
        let teleopLow = Legend(color: .pink, label: "Teleoperated Low Goal")
        
        let points: [DataPoint] = [
            .init(value: match.autoHighGoal, label: "\(Int(match.autoHighGoal))", legend: autoHigh),
            .init(value: match.autoLowGoal, label: "\(Int(match.autoLowGoal))", legend: autoLow),
            .init(value: match.teleopHighGoal, label: "\(Int(match.teleopHighGoal))", legend: teleopHigh),
            .init(value: match.teleopLowGoal, label: "\(Int(match.teleopLowGoal))", legend: teleopLow)
        ]
        
       
            
            List {
                //Scoring Card
                Section {
                    BarChartView(dataPoints: points)
                        .padding()
                }
                .navigationTitle("Match Details")
                
                Section {
                    LineChartView(dataPoints: points)
                        .padding()
                }
                
                Section {
                    HorizontalBarChartView(dataPoints: points)
                        .padding()
                }
                
                
            }
        
        
    }
}


