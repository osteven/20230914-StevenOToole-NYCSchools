//
//  HomeView.swift
//  StevenOToole-NYCSchools
//
//  Created by Steven O'Toole on 9/14/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var schoolAPI: NYCSchoolAPI
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            Text("NYC High Schools: \($viewModel.currentSelection.count)")
            Button(action: apiAction, label: {
                Text("API Call")
            })
       }
        .padding()
    }
    
    private func apiAction() {
        viewModel.load(with: schoolAPI)
     }
}

struct ContentView_Previews: PreviewProvider {
    private static let schoolAPI = NYCSchoolAPI()
    private static let viewModel: ViewModel = {
        let viewModel = ViewModel()
        viewModel.mockingSetup()
        return viewModel
    }()
    static var previews: some View {
        HomeView(schoolAPI: schoolAPI, viewModel: viewModel)
    }
}
