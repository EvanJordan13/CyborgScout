//
//  MatchScoutingView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 6/9/22.
//

import SwiftUI

struct MatchScoutingView: View {
    
    var startingPositions = ["Pilots Left Hub", "Pilots Left Edge", "Pilots Right Hub", "Pilots Right Edge"]
    @State var selectedAuto = "Pilots Left Hub"
    @State var matchNumber = ""
    @State var autoHighGoal = 0
    @State var teamNumber = ""
    @State var allianceMember1 = ""
    @State var allianceMember2 = ""
    @State var preloaded = false
    @State var taxied = false
    @State var autoLowGoal = 0
    
    var body: some View {
        
        
        NavigationView {
            
            
            
            Form {
                
                Section (header: Text("Pre-Match Scouting")) {
                    
                    TextField("Match Number", text: $matchNumber)
                        .keyboardType(.numberPad)
                        .navigationTitle("Match Scouting")
                    
                    TextField("Team Number ", text: $teamNumber)
                        .keyboardType(.numberPad)
                    
                    TextField("Alliance Member 1", text: $allianceMember1)
                        .keyboardType(.numberPad)
                    
                    TextField("Alliance Member 2", text: $allianceMember2)
                        .keyboardType(.numberPad)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Button("Done") {
                                    print("Clicked")
                                }
                            }
                        }
                    
                    Picker("Auto Starting Position", selection: $selectedAuto) {
                        ForEach(startingPositions, id: \.self) {
                            Text($0)
                        }
                    }
                    Toggle("Preloaded With Cargo", isOn: $preloaded)
                }
                    
                    Section (header: Text("Match-Time Scouting")) {
                        
                        Toggle("Taxied?", isOn: $taxied)
                        
                        Stepper("Auto High Goal Scored: \(autoHighGoal)", value: $autoHighGoal, in: 0...1000)
                        
                        Stepper("Auto Low Goal Scored: \(autoLowGoal)", value: $autoLowGoal, in: 0...1000)
                        
                       
                    }
                }
            }
            
        }
    }


struct MatchScoutingView_Previews: PreviewProvider {
    static var previews: some View {
        MatchScoutingView()
    }
}
