//
//  DataView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 6/9/22.
//

import SwiftUI

struct DataView: View {
    
    @ObservedObject var model = AppViewModel()
    
    var body: some View {
        
        NavigationView {
            
            List {
                Section(header: Text("Robots")){
                    ForEach(model.robots) { robot in
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
        
        
        
        
    }
    
    init() {
        model.getRobots()
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
