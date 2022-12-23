//
//  LoginView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 7/8/22.
//

import SwiftUI
import FirebaseAuth




struct LoginView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    @EnvironmentObject var user: User
    
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
                viewModel.signIn(email: email, password: password)
//                user.username = self.username
//                user.teamNumber = self.teamNumber
//                user.email = self.email
//                user.password = self.password
//                user.id = viewModel.getUID()
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
