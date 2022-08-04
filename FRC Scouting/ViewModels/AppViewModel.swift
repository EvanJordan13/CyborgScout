//
//  AppViewModel.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 7/13/22.
//

import Foundation
import Firebase

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    let db = Firestore.firestore()
    
    @Published var signedIn = false
    @Published var robots = [Robot]()
    @Published var matches = [Match]()
    
    var isSignedin: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
            
            
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self]result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
            
        }
    }
    
    func signOut() {
        try? auth.signOut()
        
        self.signedIn = false
    }
    
    
    func getUID() -> String {
        let uid =  auth.currentUser?.uid
        return uid!
    }
    
    func getRobots() {
        db.collection("User Data").document("\(getUID())").collection("Robots").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.robots = snapshot.documents.map { d in
                            return Robot(
                                id: d.documentID,
                                teamNumber: d["Team Number"] as? String ?? "",
                                drivetrain: d["DriveTrain"] as? String ?? "",
                                canAutoHigh: d["Can Auto High"] as? Bool ?? false,
                                canAutoLow: d["Can Auto Low"] as? Bool ?? false,
                                canTeleopHigh: d["Can Teleop High"] as? Bool ?? false,
                                canTeleopLow: d["Can Teleop Low"] as? Bool ?? false,
                                canTaxi: d["Can Taxi"] as? Bool ?? false,
                                autos: d["Autos"] as? [String] ?? [""])
                        }
                    }
                }
            } else {
                print("LMAOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO")
            }
        }
    }
    
    
    func getNumRobots() -> Int {
        let numRobotsScouted = self.robots.count
        return numRobotsScouted
    }
    
    
    
    
    
    func addRobot(teamNumber: String, drivetrain: String, canAutoHigh: Bool, canAutoLow: Bool, canTeleopHigh: Bool, canTeleopLow: Bool, canTaxi: Bool, autos: [String]) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        
        // Add a document to a collection
        //db.collection("Robots").document("\(teamNumber)").setData([
        db.collection("User Data").document("\(getUID())").collection("Robots").document("\(teamNumber)").setData([
            "Team Number": teamNumber,
            "Drivetrain": drivetrain,
            "Can Auto High": canAutoHigh,
            "Can Auto Low": canAutoLow,
            "Can Teleop High": canTeleopHigh,
            "Can Teleop Low": canTeleopLow,
            "Can Taxi": canTaxi,
            "Autos": autos]) { error in
                
                // Check for errors
                if error == nil {
                    // No errors
                    
                    // Call get data to retrieve latest data
                    self.getRobots()
                }
                else {
                    // Handle the error
                }
            }
    }
    
    
    func deleteRobot(robotToDelete: Robot) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Specify the document to delete
        db.collection("User Data").document("\(getUID())").collection("Robots").document(robotToDelete.id).delete { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Update the UI from the main thread
                DispatchQueue.main.async {
                    
                    // Remove the todo that was just deleted
                    self.robots.removeAll { robot in
                        
                        // Check for the todo to remove
                        return robot.id == robotToDelete.id
                    }
                }
            }
        }
        
    }
    
    func addMatch(matchNumber: String, teamNumber: String, allianceMember1: String, allianceMember2: String, startingPosition: String, preloaded: Bool, taxied: Bool, autoHighGoal: Int, autoLowGoal: Int,                     teleopHighGoal: Int, teleopLowGoal: Int, playedDefense: Bool, win: Bool) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        
        // Add a document to a collection
        //db.collection("User Data").document("\(getUID())").collection("Matches").document("\(matchNumber)").setData([
            
        db.collection("User Data").document("\(getUID())").collection("Robots").document("\(teamNumber)").collection("Matches").document("\(matchNumber)").setData([
            "Match Number": matchNumber,
            "Team Number": teamNumber,
            "Alliance Member 1": allianceMember1,
            "Alliance Member 2": allianceMember2,
            "Starting Position": startingPosition,
            "Preloaded With Cargo": preloaded,
            "Taxied": taxied,
            "Auto High Scored": autoHighGoal,
            "Auto Low Scored": autoLowGoal,
            "Teleop High Scored": teleopHighGoal,
            "Teleop Low Scored": teleopLowGoal,
            "Played Defense": playedDefense,
            "Won Match": win]) { error in
                
                // Check for errors
                if error == nil {
                   
                    //display succes message
            
                    
                    //self.getMatches()
                }
                else {
                    // Handle the error
                }
            }
    }
    
    
    func getTeamMatches(teamNumber: String) -> [Match] {
        let teamMatches = [Match]()
        db.collection("User Data").document("\(getUID())").collection("Robots").document("\(teamNumber)").collection("Matches").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.matches = snapshot.documents.map { d in
                            return Match(
                                id: d.documentID,
                                matchNumber: d["Match Number"] as? String ?? "",
                                teamNumber: d["Team Number"] as? String ?? "",
                                allianceMember1: d["Alliance Member 1"] as? String ?? "",
                                allianceMember2: d["Alliance Member 2"] as? String ?? "",
                                startingPosition: d["Starting Position"] as? String ?? "",
                                preloaded: d["Preloaded With Cargo"] as? Bool ?? false,
                                taxied: d["Taxied"] as? Bool ?? false,
                                autoHighGoal: d["Auto High Scored"] as? Double ?? 0,
                                autoLowGoal: d["Auto Low Scored"] as? Double ?? 0,
                                teleopHighGoal: d["Teleop High Scored"] as? Double ?? 0,
                                teleopLowGoal: d["Teleop Low Scored"] as? Double ?? 0,
                                playedDefense: d["Played Defense"] as? Bool ?? false,
                                win: d["Won Match"] as? Bool ?? false)
                        }
                                        }
                }
            } else {
                //handle error
            }
        }
        //return teamMatches
        return self.matches

    }
    
    
    
    
    
    
    
    func deleteMatch(matchToDelete: Match) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Specify the document to delete
        db.collection("User Data").document("\(getUID())").collection("Matches").document(matchToDelete.id).delete { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Update the UI from the main thread
                DispatchQueue.main.async {
                    
                    // Remove the todo that was just deleted
                    self.matches.removeAll { match in
                        
                        // Check for the todo to remove
                        return match.id == matchToDelete.id
                    }
                }
            } else {
                //handle error
            }
        }
        
    }
    
}
