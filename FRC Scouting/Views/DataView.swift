//
//  DataView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 6/9/22.
//

import SwiftUI

struct DataView: View {
    
    @ObservedObject var model = AppViewModel()
    
    var body: some View {
//        NavigationView{
//
//
//
//            //        List (model.matches) { item in
//            //            Button {
//            //
//            //            } label: {
//            //                Text("\(item.matchNumber)")
//            //                    .foregroundColor(Color.blue)
//            //
//            //            }
//            //
//            //
//            //        }
//
//
//
//
//
//            VStack {
//
//                List (model.robots) { item in
//                    Text(item.teamNumber)
//                        .swipeActions {
//                            Button(role: .destructive) {
//                                model.deleteRobot(robotToDelete: item)
//                            } label: {
//                                Label("Delete", systemImage: "trash")
//                            }
//
//                        }
//                }
//                .refreshable {
//                    model.getRobots()
//                }
//
//                Spacer()
//
//                List (model.matches) { item in
//                    Text(item.matchNumber)
//                        .swipeActions {
//                            Button(role: .destructive) {
//                                model.deleteMatch(matchToDelete: item)
//                            } label: {
//                                Label("Delete", systemImage: "trash")
//                            }
//
//                        }
//                }
//                //            .refreshable {
//                //                model.getMatches()
//                //            }
//
//
//            }
//        }
        
        
        
        List {
            ForEach(model.matches) { match in
                NavigationLink(destination: MatchBreakdownView()) {
                            
                    Text("\(match.matchNumber)")
                        }
                        
                    }
                }
                .navigationTitle("Matches")
            
        
    }
    
    init() {
        model.getRobots()
        model.getMatches()
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
