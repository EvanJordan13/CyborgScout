//
//  AppViewModel.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 7/13/22.
//

import Foundation
import Firebase
import SwiftUI

class AppViewModel: ObservableObject {
    
    var user: UserViewModel = UserViewModel()
    let auth = Auth.auth()
    let db = Firestore.firestore()
    var matchAddFailed = false
    
    @Published var robots = [Robot]()
    @Published var matches = [Match]()
    @Published var tbaTeams = [TBATeam]()
    @Published var tbaRobots = [TBARobot]()
    @Published var apiUser = [APIUser]()
    @Published var statboticsMatches = [StatboticsMatch]()
    @Published var statboticsEvents = [StatboticsEvent]()
    var averageValuePairs: [String: Int] = [:]
    var averageScore = 0
    
    func getRobots() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        db.collection("users").document("\(uid)").collection("Robots").getDocuments { snapshot, error in
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
                print("Fetching Robots Failed")
            }
        }
    }
    
    func addRobot(teamNumber: String, drivetrain: String, canAutoHigh: Bool, canAutoLow: Bool, canTeleopHigh: Bool, canTeleopLow: Bool, canTaxi: Bool, autos: [String], scores: [Int], averageScore: Int) {
        
        var currentEvent = ""
        
        getCurrentEvent { value in
                if let value = value {
                    // Assign the value to a variable or use it in any other way
                    currentEvent = value
                    
                    // Call other functions or perform actions using the variable
                    // ...
                } else {
                    // Handle the case where the value is nil or an error occurred
                    // ...
                    print("Could not add robot. Invalid Current Event")
                }
            }
        
        
       
        
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // Get a reference to the database
        let db = Firestore.firestore()
        // Add a document to a collection
        db.collection("users").document("\(uid)").collection("Events").document("\(currentEvent)").collection("Robots").document("\(teamNumber)").setData([
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
                    self.matchAddFailed = true
                }
            }
        print(currentEvent)
        db.collection("users").document("\(uid)").collection("Events").document(currentEvent).collection("Robots").document("\(teamNumber)").collection("Ranking Info").document("Ranking Info").setData([
            "scores": scores]) { error in
                
                // Check for errors
                if error == nil {
                    // No errors
                    // Call get data to retrieve latest data
                    self.getRobots()
                }
                else {
                    // Handle the error
                    self.matchAddFailed = true
                }
            }
        
        
    }
    
    func deleteRobot(robotToDelete: Robot) {
        
        var currentEvent = ""
        
        getCurrentEvent { value in
                if let value = value {
                    // Assign the value to a variable or use it in any other way
                    currentEvent = value
                    
                    // Call other functions or perform actions using the variable
                    // ...
                } else {
                    // Handle the case where the value is nil or an error occurred
                    // ...
                    print("Could not add robot. Invalid Current Event")
                }
            }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // Get a reference to the database
        let db = Firestore.firestore()
        // Specify the document to delete
        db.collection("users").document("\(uid)").collection("Events").document(currentEvent).collection("Robots").document(robotToDelete.id).delete { error in
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
    
    func addMatch(matchNumber: String, teamNumber: String, allianceMember1: String, allianceMember2: String, startingPosition: String, preloaded: Bool, taxied: Bool, autoHighGoal: Int, autoLowGoal: Int, teleopHighGoal: Int, teleopLowGoal: Int, playedDefense: Bool, win: Bool, finalScore: String) {
        
        var currentEvent = ""
        
        getCurrentEvent { value in
                if let value = value {
                    // Assign the value to a variable or use it in any other way
                    currentEvent = value
                    
                    // Call other functions or perform actions using the variable
                    // ...
                } else {
                    // Handle the case where the value is nil or an error occurred
                    // ...
                    print("Could not add robot. Invalid Current Event")
                }
            }
        
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // Get a reference to the database
        let db = Firestore.firestore()
        
        let autoPoints = (autoHighGoal * 4) + (autoLowGoal * 2)
        let teleopPoints = (teleopHighGoal * 2) + (teleopLowGoal * 1)
        let teamScore = autoPoints + teleopPoints
        // Add a match data to database
        db.collection("users").document("\(uid)").collection("Events").document(currentEvent).collection("Robots").document("\(teamNumber)").collection("Matches").document("\(matchNumber)").setData([
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
            "Won Match": win,
            "finalScore": finalScore]) { error in
                // Check for errors
                if error == nil {
                    //display succes message
                    //self.getMatches()
                }
                else {
                    // Handle the error
                }
            }
        
        
        //Add individual score to ranking info section of database to be used in overall ranking calclations
        db.collection("users").document("\(uid)").collection("Events").document(currentEvent).collection("Robots").document("\(teamNumber)").collection("Ranking Info").document("Ranking Info").getDocument { (document, error) in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }
            
            guard let document = document, document.exists else {
                print("Document doesn't exist")
                return
            }
            
            var currentScores = document.data()?["scores"] as? [Int] ?? [] // Retrieve the current array field
            
            currentScores.append(teamScore) // Append the new value to the array
            
            // Update the document with the modified array field
            db.collection("users").document("\(uid)").collection("Events").document(currentEvent).collection("Robots").document("\(teamNumber)").collection("Ranking Info").document("Ranking Info").setData(["scores": currentScores], merge: true) { error in
                if let error = error {
                    print("Error updating document: \(error.localizedDescription)")
                } else {
                    print("Scores appended successfully")
                }
            }
        }
    }
    
    func getTeamMatches(teamNumber: String) -> [Match] {
        
        var currentEvent = ""
        
        getCurrentEvent { value in
                if let value = value {
                    // Assign the value to a variable or use it in any other way
                    currentEvent = value
                    
                    // Call other functions or perform actions using the variable
                    // ...
                } else {
                    // Handle the case where the value is nil or an error occurred
                    // ...
                    print("Could not add robot. Invalid Current Event")
                }
            }
        
        let uid = Auth.auth().currentUser!.uid
        db.collection("users").document("\(uid)").collection("Events").document(currentEvent).collection("Robots").document("\(teamNumber)").collection("Matches").getDocuments { snapshot, error in
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
                                autoHighGoal: d["Auto High Scored"] as? Int ?? 0,
                                autoLowGoal: d["Auto Low Scored"] as? Int ?? 0,
                                teleopHighGoal: d["Teleop High Scored"] as? Int ?? 0,
                                teleopLowGoal: d["Teleop Low Scored"] as? Int ?? 0,
                                playedDefense: d["Played Defense"] as? Bool ?? false,
                                win: d["Won Match"] as? Bool ?? false,
                                finalScore: d["Final Score"] as? String ?? "")
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
    
    func computeAverageScore(teamNumber: String) {
        
        var currentEvent = ""
        
        getCurrentEvent { value in
                if let value = value {
                    // Assign the value to a variable or use it in any other way
                    currentEvent = value
                    
                    // Call other functions or perform actions using the variable
                    // ...
                } else {
                    // Handle the case where the value is nil or an error occurred
                    // ...
                    print("Could not add robot. Invalid Current Event")
                }
            }
        
        //Compute and add average team score to database
        //Fetch scores array
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // Get a reference to the database
        let db = Firestore.firestore()
        db.collection("users").document("\(uid)").collection("Events").document(currentEvent).collection("Robots").document("\(teamNumber)").collection("Ranking Info").document("Ranking Info").getDocument { (document, error) in
            
            //Handle errors
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }
            
            guard let document = document, document.exists else {
                print("Document doesn't exist")
                return
            }
            
            //Create variables to store database data
            let currentScores = document.data()?["scores"] as? [Int] ?? [] // Retrieve the current array field
            //Calculate average of currentScores array
            var sum = 0
            let count = currentScores.count
            currentScores.forEach { score in
                sum += score
                
            }
            
            // Update the document with the modified array field
            db.collection("users").document("\(uid)").collection("Events").document(currentEvent).collection("Robots").document("\(teamNumber)").collection("Ranking Info").document("Ranking Info").setData([
                "average score": sum/count], merge: true) { error in
                    if let error = error {
                        print("Error updating document: \(error.localizedDescription)")
                    } else {
                        print("Average Score updated successfully")
                    }
                }
        }
    }
    
    //Stores all of the average scores for all robots into a dictionary
    func storeAllAverageScores() {
        
        
        var currentEvent = ""
        
        getCurrentEvent { value in
                if let value = value {
                    // Assign the value to a variable or use it in any other way
                    currentEvent = value
                    
                    // Call other functions or perform actions using the variable
                    // ...
                } else {
                    // Handle the case where the value is nil or an error occurred
                    // ...
                    print("Could not add robot. Invalid Current Event")
                }
            }
        
        //get current user's id
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // Get a reference to the database
        let db = Firestore.firestore()
        
        //Iterate through all matches and add them to the averageValuePairs dictionary
        robots.forEach { robot in
            
            //Compute the Average Score
            computeAverageScore(teamNumber: robot.teamNumber)
            //Create variable to store each robot's average score
            
            //Get ranking info section from database
            db.collection("users").document("\(uid)").collection("Events").document(currentEvent).collection("Robots").document("\(robot.teamNumber)").collection("Ranking Info").document("Ranking Info").getDocument { (document, error) in
                
                //Handle errors
                if let error = error {
                    print("Error fetching document: \(error.localizedDescription)")
                    return
                }
                
                guard let document = document, document.exists else {
                    print("Document doesn't exist")
                    return
                }
                //Set the average score of the current robot to the database's data
                self.averageScore = document.data()?["average score"] as? Int ?? 98
            }
            
            //Add the teamNumber-averageValue pair to the dictionary
            averageValuePairs[robot.teamNumber] = averageScore
            
            
            
            
            
            
            
        }
        
        //Iterate over the dictionary and add the dictionary's data to the database
        for (team, averageScore) in averageValuePairs {
            db.collection("users").document("\(uid)").collection("Events").document(currentEvent).collection("Robots").document("\(team)").collection("Ranking Info").document("Ranking Info").setData([
                "average score": averageScore], merge: true) { error in
                    if let error = error {
                        print("Error updating document: \(error.localizedDescription)")
                    } else {
                        print("Average Score updated successfully")
                    }
                }
        }
        
    }
    
    
    //Returns the average score of a desired team
    func getAverageScore(teamNumber: String, completion: @escaping (Result<Int, Error>) -> Void) {
        
        var currentEvent = ""
        
        getCurrentEvent { value in
                if let value = value {
                    // Assign the value to a variable or use it in any other way
                    currentEvent = value
                    
                    // Call other functions or perform actions using the variable
                    // ...
                } else {
                    // Handle the case where the value is nil or an error occurred
                    // ...
                    print("Could not add robot. Invalid Current Event")
                }
            }
        
        //Get current user's uid
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // Get a reference to the database
        let db = Firestore.firestore()
        //Create variable to hold specific document reference
        let docRef = db.collection("users").document("\(uid)").collection("Events").document(currentEvent).collection("Robots").document("\(teamNumber)").collection("Ranking Info").document("Ranking Info")
        //Get snapshot of the document
        docRef.getDocument { (document, error) in
            //Handle error if there is an issue getting document
            if let error = error {
                completion(.failure(error))
                return
            }
            //More error handling
            guard let document = document, document.exists else {
                let documentNotFoundError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Document doesn't exist ehe"])
                completion(.failure(documentNotFoundError))
                return
            }
            //Mark getting data as a sucess if value is stored correctly. If not, handle error
            if let value = document.data()?["average score"] as? Int {
                completion(.success(value))
            } else {
                let invalidDataError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data type or field not found"])
                completion(.failure(invalidDataError))
            }
        }
    }
    
    func deleteMatch(matchToDelete: Match) {
        
        var currentEvent = ""
        
        getCurrentEvent { value in
                if let value = value {
                    // Assign the value to a variable or use it in any other way
                    currentEvent = value
                    
                    // Call other functions or perform actions using the variable
                    // ...
                } else {
                    // Handle the case where the value is nil or an error occurred
                    // ...
                    print("Could not add robot. Invalid Current Event")
                }
            }
        
        let uid = Auth.auth().currentUser!.uid
        // Get a reference to the database
        let db = Firestore.firestore()
        // Specify the document to delete
        db.collection("users").document("\(uid)").collection("Events").document(currentEvent).collection("Robots").document("\(matchToDelete.teamNumber)").collection("Matches").document(matchToDelete.id).delete { error in
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
    
    
    func fetchStatboticsMatches() async {
        guard let url = URL(string:"https://api.statbotics.io/v2/matches/team/4256/year/2023") else {
            print("URL doesnt work")
            return
        }
        
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([StatboticsMatch].self, from: data) {
                print("should have worked")
                DispatchQueue.main.async {
                    self.statboticsMatches = decodedResponse
                }
                
            } else {
                print("didnt decode")
            }
        } catch {
            print("data isnt valid")
        }
    }
    
    func fetchStatboticsEvents() async {
        guard let url = URL(string:"https://api.statbotics.io/v2/events/year/2023") else {
            print("URL doesnt work")
            return
        }
        
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([StatboticsEvent].self, from: data) {
                print("should have worked")
                DispatchQueue.main.async {
                    self.statboticsEvents = decodedResponse
                }
                
            } else {
                print("didnt decode")
            }
        } catch {
            print("data isnt valid")
        }
    }
    
    func setCurrentEvent(event: String) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // Get a reference to the database
        let db = Firestore.firestore()
        
        db.collection("users").document("\(uid)").setData([
            "Current Event": event
        ]) { error in
            // Check for errors
            if error == nil {
                //display succes message
                print("selected current event succesfull. Current event: \(event)")
            }
            else {
                // Handle the error
                print("Selected event assignement failed")
            }
        }
    }
    
    //returns the current event being scouted
    func getCurrentEvent(completion: @escaping (String?) -> Void) {
        // Replace "your-firebase-project-id" with your actual Firebase project ID
        //Get current user's uid
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // Get a reference to the database
        let db = Firestore.firestore()
        //Create variable to hold specific document reference
        let docRef = db.collection("users").document("\(uid)")
        
        // Replace "your-collection" and "your-document" with the path to your document
        docRef.getDocument { (snapshot, error) in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let snapshot = snapshot, snapshot.exists else {
                print("Document does not exist")
                completion(nil)
                return
            }
            
            // Replace "your-field" with the field name you want to retrieve
            if let fieldValue = snapshot.data()?["Current Event"] as? String {
                completion(fieldValue)
            } else {
                print("Field does not exist or has a different type")
                completion(nil)
            }
        }
    }
    
    
    
    
    //Needed for getting average scores
    init() {
        getRobots()
    }
}



