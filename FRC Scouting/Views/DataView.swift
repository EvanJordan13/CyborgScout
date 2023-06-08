//
//  DataView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 6/9/22.
//

import SwiftUI

struct DataView: View {
    
    @StateObject var model = AppViewModel.shared

    var body: some View {
        
        NavigationView {
            
            List {
                Section(header: Text("Robots")){
                    ForEach(model.robots) { robot in
                        //Error is happening in robotspecs view
                        NavigationLink(destination: RobotSpecsView(teamNumber: robot.teamNumber)) {
                            RobotCardView(robot: robot)
                            
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                model.deleteRobot(robotToDelete: robot)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        
                    }
                }
                .navigationTitle("Data")
            }
            .refreshable {
                model.getRobots()
            }
        }
        .onAppear {
            model.getRobots()
        }
        
        
        
        
    }
    
    
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
