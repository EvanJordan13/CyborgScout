//
//  DataView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 6/9/22.
//

import SwiftUI

struct DataView: View {
    
    @ObservedObject var model = AppViewModel()
    
    var body: some View {
        
        VStack {
            
            List (model.list) { item in
                Text(item.teamNumber)
            }
            
        }
        
    }
    
    init() {
        model.getData()
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
