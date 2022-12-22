//
//  AccountView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 12/21/22.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject var model = AppViewModel()
    var body: some View {
        //viewModel.addUserInfo(username: username, teamNumber: teamNumber)
        Button(action: {
            model.signOut()
        },
               
               label: {
            Text("Sign Out")
            
                .frame(width: 200, height: 50)
                .background(Color.blue)
                .cornerRadius(8)
                .foregroundColor(Color.white)
        })
        
        
        
        
        
//                Section {
//                    VStack{
//                        HStack{
//                            Text("Username: ")
//                            Spacer()
//                            Text("\()")
//                        }
//                        .padding()
//
//                        Spacer()
//
//                        HStack{
//                            Text("Team Number:")
//                            Spacer()
//                            Text("\()")
//                        }
//                        .padding()
//
//                        HStack{
//                            Text("Alliance Member 1:")
//                            Spacer()
//                            Text("\(match.allianceMember1)")
//                        }
//                        .padding()
//
//                        HStack{
//                            Text("Alliance Member 2:")
//                            Spacer()
//                            Text("\(match.allianceMember1)")
//                        }
//                        .padding()
//
//                        HStack{
//                            Text("Individual Robot Score:")
//                            Spacer()
//                            Text("\(getRobotScore())")
//                        }
//                        .padding()
//
//                    }
//                }
    }
    
    //struct AccountView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        AccountView()
    //    }
    //}
}
