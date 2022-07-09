//
//  LoginView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 7/8/22.
//

import SwiftUI
import FirebaseAuth


class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedin: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
        }
    }
    
    
    
    
}

struct LoginView: View {
    
    @EnvironmentObject  var viewModel: AppViewModel
    
    private enum FieldToFocus: Int, CaseIterable {
        case email, password
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
                .keyboardType(.numberPad)
                .focused($focusedField, equals: .password)
                .padding()
            
            Button(action: {
                guard !email.isEmpty, !password.isEmpty else {
                    return
                }
                viewModel.signIn(email: email, password: password)
                    },
                   
                   label: {
                Text("Sign In")
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .foregroundColor(Color.white)
            })
        }
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
