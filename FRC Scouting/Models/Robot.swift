//
//  Robot.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 7/13/22.
//

import Foundation

struct Robot: Identifiable {
    var id: String
    var teamNumber: String
    var drivetrain: String
    var canAutoHigh: Bool
    var canAutoLow: Bool
    var canTeleopHigh: Bool
    var canTeleopLow: Bool
    var canTaxi: Bool
    var autos: [String]
}
