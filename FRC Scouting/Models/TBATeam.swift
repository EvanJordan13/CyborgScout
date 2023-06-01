//
//  TBATeam.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 5/31/23.
//

import Foundation

struct TBATeam: Hashable, Codable {
    
      let address: String
      let city: String
      let country: String
      let gmaps_place_id: String
      let gmaps_url: String
      let key: String
      let lat: String
      let lng: String
      let location_name: String
      let motto: String
      let name: String
      let nickname: String
      let postal_code: String
      let rookie_year: Int
      let school_name: String
      let state_prov: String
      let team_number: Int
      let website: String
}
