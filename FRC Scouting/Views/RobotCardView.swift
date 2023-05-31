//
//  RobotCardView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 7/28/22.
//


import SwiftUI

struct RobotCardView: View {
    @ObservedObject var model = AppViewModel()
    let robot: Robot
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Team \(robot.teamNumber)")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                Label("Average Points: \(robot.teamNumber)", systemImage: "flag.2.crossed")
                Spacer()
                Label("Rank: --", systemImage: "flag")
                
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(.primary)
    }
}

