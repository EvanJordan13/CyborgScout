//
//  APIView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 6/1/23.
//

import SwiftUI

struct EventsView: View {
    @StateObject var model = AppViewModel()
    @State var selectedEvent = ""
    @State var showingAddEventSuccessAlert = false
    
    var body: some View {
        let events = model.statboticsEvents
        
        NavigationView {
            VStack {
                Form {
                    Section {
                        Picker("Event", selection: $selectedEvent) {
                            ForEach(events, id: \.name) { event in
                                Text(event.name)
                            }
                        }
                    }
                    Button(action: {
                        //model.setCurrentEvent(event: selectedEvent)
                        model.currentEvent = selectedEvent
                        showingAddEventSuccessAlert = true
                    },
                           label: {
                        Text("Confirm Event")
                            .foregroundColor(Color.blue)
                    })
                    .alert("Now scouting for \(model.currentEvent). To change event, change selection and confirm again. Happy Scouting!", isPresented: $showingAddEventSuccessAlert) {
                                Button("OK", role: .cancel) { }
                            }
                }
                
                
                .navigationTitle("Select Event")
                
               
            }
            
        }
        .task {
            // await model.fetchTBARobots()
            // await model.fetchUser()
            // await model.fetchStatboticsMatches()
            await model.fetchStatboticsEvents()
        }
        .onAppear {
            
        }
    }
}

