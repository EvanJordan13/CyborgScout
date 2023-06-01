//
//  APIView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 6/1/23.
//

import SwiftUI

struct APIView: View {
    @ObservedObject var model = AppViewModel()
    
    var body: some View {
        List{
            ForEach(model.statboticsEvents, id: \.key) { event in
                Text(event.name)
            }
            
//                        ForEach(model.tbaRobots, id: \.year) { robot in
//                            Text(robot.robot_name)
//                        }
//            ForEach(model.apiUser, id: \.id) { user in
//                Text(user.name)
//            }
            
        }
        .task {
            //await model.fetchTBARobots()
           /// await model.fetchUser()
//            await model.fetchStatboticsMatches()
            await model.fetchStatboticsEvents()

            
        }
    }
}

struct APIView_Previews: PreviewProvider {
    static var previews: some View {
        APIView()
    }
}
