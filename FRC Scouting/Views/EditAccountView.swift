//
//  EditAccountView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 12/22/22.
//

import SwiftUI

struct EditAccountView: View {
    
    
    @EnvironmentObject var user: UserViewModel
    @ObservedObject var model = AppViewModel()
    
    private enum FieldToFocus: Int, CaseIterable {
        case email, password, username, teamNumber
    }
    @FocusState private var focusedField: FieldToFocus?
    
    @State var username: String = ""
    @State var email: String = ""
    @State private var password: String = ""
    @State var teamNumber: String = ""
    
    
    
    var body: some View {
        Text("hehe")
        VStack {
            TextField("Username: ", text: $username)
                .keyboardType(.default)
                .focused($focusedField, equals: .email)
                .padding()
                .onAppear {
                    self.username = "\(user.user?.username ?? "")"
                }

            TextField("Team Number: ", text: $teamNumber)
                .keyboardType(.default)
                .focused($focusedField, equals: .email)
                .padding()
                .onAppear {
                    self.teamNumber = "\(user.user?.teamNumber ?? "")"
                }

            TextField("Email: ", text: $email)
                .keyboardType(.default)
                .focused($focusedField, equals: .email)
                .padding()
                .onAppear {
                    self.email = "\(user.user?.email ?? "")"
                }

            Button(action: {
                guard !email.isEmpty, !password.isEmpty, !username.isEmpty, !teamNumber.isEmpty else {
                    return
                }
                            },

                   label: {
                Text("Update Account")
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .foregroundColor(Color.white)
            })


        }
        .navigationTitle("Edit Account Info")
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done") {
                    focusedField = nil
                }
            }
        }
    }
}
//struct EditAccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditAccountView()
//    }
//}
