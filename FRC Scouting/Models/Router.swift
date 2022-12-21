//
//  Router.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 12/20/22.
//

import Foundation

class Router: ObservableObject {
    static let shared = Router()  // singleton and available for everyone!
    
    @Published var selectedTab = 0
}
