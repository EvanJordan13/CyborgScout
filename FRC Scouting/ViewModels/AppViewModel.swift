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
    @Published var list = [Robot]()
    
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
    
    func getData() {
        db.collection("Robots").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map { d in
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
    
    
    func addData() {
        db.collection("Robots").document("1111").setData([
            "Team Number": "1111",
            "Can Taxi": true,
            "Can Auto High": true
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func addRobot( teamNumber: String, drivetrain: String, canAutoHigh: Bool, canAutoLow: Bool, canTeleopHigh: Bool, canTeleopLow: Bool, canTaxi: Bool, autos: [String]) {
            
            // Get a reference to the database
            let db = Firestore.firestore()
            
            // Add a document to a collection
            db.collection("Robots").addDocument(data:[
                                                
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
                    self.getData()
                }
                else {
                    // Handle the error
                }
            }
        }
    
    func deleteData(robotToDelete: Robot) {
            
            // Get a reference to the database
            let db = Firestore.firestore()
            
            // Specify the document to delete
            db.collection("Robots").document(robotToDelete.id).delete { error in
                
                // Check for errors
                if error == nil {
                    // No errors
                    
                    // Update the UI from the main thread
                    DispatchQueue.main.async {
                        
                        // Remove the todo that was just deleted
                        self.list.removeAll { robot in
                            
                            // Check for the todo to remove
                            return robot.id == robotToDelete.id
                        }
                    }
                    
                    
                }
            }
            
        }
    
    
    
    
    
}
