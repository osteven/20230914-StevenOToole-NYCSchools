//
//  HomeView.swift
//  StevenOToole-NYCSchools
//
//  Created by Steven O'Toole on 9/14/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var schoolAPI: NYCSchoolAPI
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button(action: apiAction, label: {
                Text("API Call")
            })
       }
        .padding()
    }
    
    private func apiAction() {
        schoolAPI.getSchools { result in
            switch result {
            case .success(let schools):
                print("🟢 \(schools.count)")
                for school in schools {
                    print("\t\(school.id) \(school.name)")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
     }
}

struct ContentView_Previews: PreviewProvider {
    private static let schoolAPI = NYCSchoolAPI()
    static var previews: some View {
        HomeView(schoolAPI: schoolAPI)
    }
}
