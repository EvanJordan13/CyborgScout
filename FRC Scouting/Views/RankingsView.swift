//
//  RankingsView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 5/30/23.
//

import SwiftUI

struct RankingsView: View {
    @ObservedObject var model = AppViewModel.shared
    @State var averageScores: [String: Int] = [:] // Dictionary to store average scores
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sortedRobots(), id: \.teamNumber) { robot in
                    if let averageScore = averageScores[robot.teamNumber] {
                        let rank = rank(for: robot)
                        Text("\(rank). Team: \(robot.teamNumber), Average Score: \(averageScore)")
                    } else {
                        Text("Loading...")
                            .onAppear {
                                model.getAverageScore(teamNumber: robot.teamNumber) { result in
                                    switch result {
                                    case .success(let value):
                                        DispatchQueue.main.async {
                                            averageScores[robot.teamNumber] = value // Store the average score in the dictionary
                                        }
                                    case .failure(let error):
                                        // Handle the error case here
                                        //print("Error: \(error.localizedDescription)")
                                        return
                                    }
                                }
                            }
                    }
                }
            }
            .navigationBarTitle("Rankings")
            
        }
    }
    
    func sortedRobots() -> [Robot] {
        return model.robots.sorted { (robot1, robot2) in
            let averageScore1 = averageScores[robot1.teamNumber] ?? 0
            let averageScore2 = averageScores[robot2.teamNumber] ?? 0
            return averageScore1 > averageScore2
        }
    }
    
    func rank(for robot: Robot) -> Int {
        let sortedRobots = sortedRobots()
        if let index = sortedRobots.firstIndex(where: { $0.teamNumber == robot.teamNumber }) {
            return index + 1
        }
        return 0
    }
}
