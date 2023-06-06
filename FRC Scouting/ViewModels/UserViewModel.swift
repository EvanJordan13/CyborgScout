//
//  UserViewModel.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 5/28/23.
//

import Foundation

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

class UserViewModel: ObservableObject {
    
    //Makes singleton of this class
    static let sharedUser = UserViewModel()
    

    @Published var user: User?
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    init() {}
    
    var uuid: String? {
        auth.currentUser?.uid
    }
    var userIsAuthenticated: Bool {
        auth.currentUser != nil
    }
    var userIsAuthenticatedAndSynced: Bool {
        user != nil && self.userIsAuthenticated
    }
    
    // MARK: Firebase Auth Functions
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else { return }
            // Successfully authenticated the user, now attempting to sync with Firestore
            DispatchQueue.main.async {
                self?.sync()
            }
            UserDefaults.standard.set(true, forKey: "Logged In")
            UserDefaults.standard.set(email, forKey: "Current User Email")
            UserDefaults.standard.set(password, forKey: "Current User Password")

            
        }
    }
    
    func signUp(email: String, username: String, teamNumber: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else { return }
            DispatchQueue.main.async {
                self?.add(User(username: username, teamNumber: teamNumber, email: email))
                self?.sync()
                UserDefaults.standard.set(true, forKey: "Logged In")
                UserDefaults.standard.set(email, forKey: "Current User Email")
                UserDefaults.standard.set(password, forKey: "Current User Password")
            }
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            self.user = nil
            UserDefaults.standard.set(false, forKey: "Logged In")
            UserDefaults.standard.set("", forKey: "Current User Email")
            UserDefaults.standard.set("", forKey: "Current User Password")
        } catch {
            print("Error signing out the user: \(error)")
        }
    }
    
     func sync() {
        guard userIsAuthenticated else {
            return
        }
        
        db.collection("users").document(self.uuid!).getDocument { (document, error) in
            guard document != nil, error == nil else {
                return
            }
            do {
                try self.user = document!.data(as: User.self)
            } catch {
                print("Sync error: \(error)")
            }
        }
    }
    
    
    private func add(_ user: User) {
        guard userIsAuthenticated else {
            return
        }
        do {
            let _ = try db.collection("users").document(self.uuid!).setData(from: user)
        } catch {
            print("Error adding: \(error)")
        }
    }
    
    private func update() {
        guard userIsAuthenticatedAndSynced else {
            return
        }
        do {
            let _ = try db.collection("users").document(self.uuid!).setData(from: self.user)
        } catch {
            print("Error updating: \(error)")
        }
    }
}
