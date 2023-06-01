//
//  TeamInfoView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 5/31/23.
//

import SwiftUI

struct TeamInfoView: View {
    @StateObject var model = AppViewModel()
    var body: some View {
        NavigationView {
            List {
                
                    ForEach(model.tbaTeams, id: \.self) { team in
                        Text(team.nickname)
                    }
            
            }
            .navigationTitle("Team Info")
            .onAppear {
                model.fetchTBATeam(teamNumber: "4256")
            }
        }
    }
}

struct TeamInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TeamInfoView()
    }
}
