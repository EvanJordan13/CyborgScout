//
//  RobotCardView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 7/28/22.
//


import SwiftUI

struct RobotCardView: View {
    @ObservedObject var model = AppViewModel.shared
    let robot: Robot
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Team \(robot.teamNumber)")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            
        }
        .padding()
        .foregroundColor(.primary)
    }
}

