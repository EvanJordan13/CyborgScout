//
//  SignUpView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 12/22/22.
//

import SwiftUI

struct SignUpView: View {
    
    
    @StateObject var viewModel = AppViewModel.shared
    @StateObject var user = UserViewModel.sharedUser
    
    private enum FieldToFocus: Int, CaseIterable {
        case email, password, username, teamNumber
    }
    @FocusState private var focusedField: FieldToFocus?
    
    @State public var username = ""
    @State private var email: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var password: String = ""
    @State public var teamNumber = ""
    

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
                user.signUp(email: email, username: username, teamNumber: teamNumber, password: password)
                
            },
                   
                   label: {
                Text("Create Account")
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
