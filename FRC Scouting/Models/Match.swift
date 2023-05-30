//
//  Match.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 7/26/22.
//

import Foundation

struct Match: Identifiable {
    var id: String
    var matchNumber: String
    var teamNumber: String
    var allianceMember1: String
    var allianceMember2: String
    var startingPosition: String
    var preloaded: Bool
    var taxied: Bool
    var autoHighGoal: Int
    var autoLowGoal: Int
    var teleopHighGoal: Int
    var teleopLowGoal: Int
    var playedDefense: Bool
    var win: Bool
    var finalScore: String
}
