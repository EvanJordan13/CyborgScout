//
//  MatchCardView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 7/27/22.
//

import SwiftUI

struct MatchCardView: View {
    //@ObservedObject var model = AppViewModel.shared
    let match: Match

        var body: some View {
            VStack(alignment: .leading) {
                Text("Match \(match.matchNumber)")
                    .font(.headline)
                Spacer()
                HStack {
                    Label("Team \(match.teamNumber)", systemImage: "person.3")
                    Spacer()
                    Label(match.win ? "Match Won" : "Match Lost", systemImage: "crown")
                        
                }
                .font(.caption)
            }
            .padding()
            .foregroundColor(.primary)
        }
}


