//
//  AccountView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 12/21/22.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject var model = AppViewModel()
    @EnvironmentObject var user: User
    var body: some View {
        NavigationView {
            Section {
                List{
                    HStack{
                        Text("Username: ")
                        Spacer()
                        Text("\(user.username)")
                    }
                    .padding()
                    
                    HStack{
                        Text("Email Address: ")
                        Spacer()
                        Text("\(user.teamNumber)")
                    }
                    .padding()
                    
                    
                    HStack{
                        Text("Team Number:")
                        Spacer()
                        Text("\(user.teamNumber)")
                    }
                    .padding()
                    
                    //Spacer()
                    
                    NavigationLink(destination: EditAccountView()) {
                        Text("Edit Account Information")
                    }
                    
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
                    
                }
            }
            .navigationTitle("")
        }
    }
    
    //struct AccountView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        AccountView()
    //    }
    //}
}
