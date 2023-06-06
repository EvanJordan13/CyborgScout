//
//  LoginView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 7/8/22.
//

import SwiftUI
import FirebaseAuth




struct LoginView: View {
    
    @StateObject var viewModel = AppViewModel.shared
    @StateObject var user = UserViewModel.sharedUser
    
    private enum FieldToFocus: Int, CaseIterable {
        case email, password, username
    }
    @FocusState private var focusedField: FieldToFocus?
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            
            
            
            TextField("Email: ", text: $email)
                .keyboardType(.default)
                .focused($focusedField, equals: .email)
                .padding()
            
            SecureField("Password:", text: $password)
                .keyboardType(.default)
                .focused($focusedField, equals: .password)
                .padding()
            
            Button(action: {
                guard !email.isEmpty, !password.isEmpty else {
                    return
                }
                user.signIn(email: email, password: password)
                
            },
                   
                   label: {
                Text("Login")
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .foregroundColor(Color.white)
            })
            
            
            NavigationLink("Create Account", destination: SignUpView())
                .padding()
            
        }
        .navigationTitle("Login")
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done") {
                    focusedField = nil
                }
            }
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.dark)
    }
}
