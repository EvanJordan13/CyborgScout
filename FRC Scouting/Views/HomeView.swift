//
//  HomeView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 6/9/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject public  var viewModel: AppViewModel

    var body: some View {
        VStack {
        Text("Home")
        
        Button(action: {
            viewModel.signOut()
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
