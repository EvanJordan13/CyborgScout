//
//  RobotPerformance.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 5/8/22.
//

import Foundation

class RobotPerformance{
    
    enum StartingPosition {
        case Blank
        case PilotsRightHub
        case PilotsRightEdge
        case PilotsLeftHub
        case PilotsLeftEdge
    }
    
    enum ClimbPosition {
        case NoClimb
        case Left
        case Middle
        case Right
        
    }
    
    enum ClimbStatus {
        case NoClimb
        case LowBar
        case mediumBar
        case HighBar
        case TraverseBar
    }
    
    var teamNumber: Int
    var matchNumber: Int
    var allianceMember1: Int
    var allianceMember2: Int
    var startPosition: StartingPosition
    var taxi: Bool
    var autoHighGoalScored: Int
    var autoLowGoalScored: Int
    var teleopHighGoalScored: Int
    var teleopLowGoalScored: Int
    var climbStartTime: Double
    var climbPosition: ClimbPosition
    var climbStatus: ClimbStatus
    
    init() {
        teamNumber = 0
        matchNumber = 0
        allianceMember1 = 0
        allianceMember2 = 0
        startPosition = StartingPosition.Blank
        taxi = false
        autoHighGoalScored = 0
        autoLowGoalScored = 0
        teleopHighGoalScored = 0
        teleopLowGoalScored = 0
        climbStartTime = 0.00
        climbPosition = ClimbPosition.NoClimb
        climbStatus = ClimbStatus.NoClimb
    }
    
    func setTeamNumber(number: String) {
//        if ((Int(number) ?? 0) == 0) {
//
//        }
        //else {
            self.teamNumber = Int(number) ?? 0
        //}
        
    }
    
    func setStartPosition(position: StartingPosition) {
        self.startPosition = position
    }
    
    func setTaxi(taxi: Bool) {
        self.taxi = taxi
    }
    
    func incrementAutoHighGoal() {
        self.autoHighGoalScored += 1
    }
    
    func incrementAutoLowGoal() {
        self.autoLowGoalScored += 1
    }
    
    func incrementTelopHighGoal() {
        self.teleopHighGoalScored += 1
    }
    
    func incrementTeleopLowGoal() {
        self.autoLowGoalScored += 1
    }
    
    func decrementAutoHighGoal() {
        self.autoHighGoalScored -= 1
    }
    
    func decrementAutoLowGoal() {
        self.autoLowGoalScored -= 1
    }
    
    func decrementTelopHighGoal() {
        self.teleopHighGoalScored -= 1
    }
    
    func decrementTeleopLowGoal() {
        self.autoLowGoalScored -= 1
    }
    
    func setClimbStartTime (time: Double) {
        self.climbStartTime = time
    }
    
    func setClimbPosition (position: ClimbPosition) {
        self.climbPosition = position
    }
    
    func setClimbStatus (status: ClimbStatus) {
        self.climbStatus = status
    }
    
    func getTeamNumber() -> Int {
        return self.teamNumber
    }
    
    func getStartPosition() -> String {
        switch self.startPosition {
        case .Blank:
            return "No Position Selected"
        case .PilotsRightHub:
            return "Pilots Right Flush To Hub"
        case .PilotsRightEdge:
            return "Pilots Right On Edge of Tarmac"
        case .PilotsLeftHub:
            return "Pilots Left Flush To Hub"
        case .PilotsLeftEdge:
            return "Pilots Left On Edge of Tarmac"
        }
    }
    
    func getTaxi() -> Bool {
        return self.taxi
    }
    
    func getAutoHighGoalScored() -> Int {
        return self.autoHighGoalScored
    }
    
    func getAutoLowGoalScored() -> Int {
        return self.autoLowGoalScored
    }
    
    func getTeleopHighGoalScored() -> Int {
        return self.teleopHighGoalScored
    }
    
    func getTeleopLowGoalScored() -> Int {
        return self.teleopLowGoalScored
    }
    
    func getClimbStartTime() -> Double {
        return self.climbStartTime
    }
    
    func getClimbPosition() -> String {
        switch self.climbPosition {
        case .NoClimb:
            return "Robot Did Not Climb"
        case .Left:
            return "Robot Climbed Pilots Left"
        case .Middle:
            return "Robot Climbed Pilots Middle"
        case .Right:
            return "Robot Climbed Pilots Right"
        }
    }
    
    func getClimbStatus() -> String {
        switch self.climbStatus {
        case .NoClimb:
            return "Robot Did Not Climb"
        case .LowBar:
            return "Robot Climbed To Low Bar"
        case .mediumBar:
            return "Robot Climbed to Medium Bar"
        case .HighBar:
            return "Robot Climbed to High Bar"
        case .TraverseBar:
            return "Robot Climbed to Traverse Bar"
        }
    }
}
