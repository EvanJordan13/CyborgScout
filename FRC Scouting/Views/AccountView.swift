//
//  AccountView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 12/21/22.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var user: UserViewModel
    var body: some View {
        NavigationView {
            Section {
                List{
                    HStack{
                        Text("Username: ")
                        Spacer()
                        Text("\(user.user?.username ?? "")")
                    }
                    .padding()
                    
                    HStack{
                        Text("Email Address: ")
                        Spacer()
                        Text("\(user.user?.email ?? "")")
                    }
                    .padding()
                    
                    
                    HStack{
                        Text("Team Number:")
                        Spacer()
                        Text("\(user.user?.teamNumber ?? "")")
                    }
                    .padding()
                    
                    
                    HStack{
                        
                        
                        Button(action: {
                            user.signOut()
                            UserDefaults.standard.set(user.userIsAuthenticatedAndSynced, forKey: "Logged In")
                            
                        },
                               
                               label: {
                            Text("Sign Out")
                            
                                .frame(maxWidth: .infinity, alignment: .center)
                                //.background(Color.red)
                                .cornerRadius(8)
                                .foregroundColor(Color.red)
                        })
                    }
                    
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
