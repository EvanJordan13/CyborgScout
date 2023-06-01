//
//  TeamInfoView.swift
//  FRC Scouting
//
//  Created by Evan Jordan on 5/31/23.
//

import SwiftUI
struct Response: Codable {
    var results: [Product]
}

struct Product: Codable {
//    var trackId: Int
//    var trackName: String
//    var collectionName: String
    var id: Int
    var name: String
    
}
struct TeamInfoView: View {
    @ObservedObject var model = AppViewModel()
    @State private var results = [Product]()
    var body: some View {
        List(results, id: \.id) { item in
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text ("\(item.id)")
            }
            
        }
        .task {
            await loadData()
        }
    }
    func loadData() async {
        //Create URL to read
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            print("Invalid URL")
            return
        }
        
        //Fetch data from URL
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            } else {
                print("didnt decode")
            }
            
        } catch {
            print("Invalid Data")
        }
        
        
        //Decode JSON data
    }
}


struct TeamInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TeamInfoView()
    }
}
