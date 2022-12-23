//
//  SignUpView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 12/22/22.
//

import SwiftUI

struct SignUpView: View {
    
        
        @EnvironmentObject var viewModel: AppViewModel
        @EnvironmentObject var user: User
        
        private enum FieldToFocus: Int, CaseIterable {
            case email, password, username, teamNumber
        }
        @FocusState private var focusedField: FieldToFocus?
        
        @State var username = ""
        @State var email = ""
        @State private var password = ""
        @State var teamNumber = ""

        
        var body: some View {
            VStack {
                
                
                TextField("Username: ", text: $username)
                    .keyboardType(.default)
                    .focused($focusedField, equals: .email)
                    .padding()
                
                TextField("Team Number: ", text: $teamNumber)
                    .keyboardType(.default)
                    .focused($focusedField, equals: .email)
                    .padding()
                
                TextField("Email: ", text: $email)
                    .keyboardType(.default)
                    .focused($focusedField, equals: .email)
                    .padding()
                
                SecureField("Password:", text: $password)
                    .keyboardType(.default)
                    .focused($focusedField, equals: .password)
                    .padding()
                
                Button(action: {
                    guard !email.isEmpty, !password.isEmpty, !username.isEmpty, !teamNumber.isEmpty else {
                        return
                    }
                    viewModel.signUp(email: email, password: password)
                    viewModel.signIn(email: email, password: password)
                    user.username = self.username
                    user.teamNumber = self.teamNumber
                    user.email = self.email
                    user.password = self.password
                    user.id = viewModel.getUID()
                    viewModel.addUserInfo(username: username, teamNumber: teamNumber)
                    

                       },
                       
                       label: {
                    Text("Create Account")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .foregroundColor(Color.white)
                })
                
                
                Button(action: {
                    guard !username.isEmpty, !teamNumber.isEmpty else {
                        return
                    }
                    viewModel.addUserInfo(username: username, teamNumber: teamNumber)
                       },
                       
                       label: {
                    Text("Update Info")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .foregroundColor(Color.white)
                })
                
                
            }
            .navigationTitle("Create Account")
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        focusedField = nil
                    }
                }
            }
        }
    
}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
