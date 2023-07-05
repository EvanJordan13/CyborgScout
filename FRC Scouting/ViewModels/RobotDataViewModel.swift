//
//  AppViewModel.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 7/13/22.
//

import Foundation
import Firebase
import SwiftUI

class RobotDataViewModel: ObservableObject {
    //Makes singleton of this class
    static let shared = RobotDataViewModel()
    
    var teamNumber = "0"
    
    func setCurrentTeamNumber (teamNumber: String) {
        self.teamNumber = teamNumber
    }
    
}



