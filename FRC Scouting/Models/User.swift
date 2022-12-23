//
//  User.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 12/22/22.
//

import Foundation

class User: Identifiable, ObservableObject {
    static let shared = User()
    @Published var id: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var username: String = ""
    @Published var teamNumber: String = ""
   
}
