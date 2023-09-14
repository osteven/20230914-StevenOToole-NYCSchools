//
//  HomeView.swift
//  StevenOToole-NYCSchools
//
//  Created by Steven O'Toole on 9/14/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var schoolAPI: NYCSchoolAPI
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        StandardLayoutView {
            VStack {
                Text("NYC High Schools: \($viewModel.currentSelection.count)")
                if viewModel.currentSelection.isEmpty {
                    Button(action: apiAction, label: {
                        Text("API Call")
                    })
                } else {
                    SchoolListView()
                }
            }
            .padding()
        }
    }
    
    private func apiAction() {
        viewModel.load(with: schoolAPI)
     }
}


private struct SchoolListView: View {
    @EnvironmentObject var viewModel: ViewModel    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 8) {
                ForEach(Array(viewModel.currentSelection.enumerated()), id: \.offset) { index, item in
                    SchoolListCellView(item: item)
                }
            }
        }
    }
}

private struct SchoolListCellView: View {
    let item: HighSchool
    var body: some View {
        HStack {
            Text("\(item.name)")
                .frame(alignment: .leading)
                .padding()
            Spacer()
        }
        .frame(minHeight: 48)
        .background(Color.Palette.red.opacity(0.2))
        .cornerRadius(8)
    }
}

// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    private static let schoolAPI = NYCSchoolAPI()
    private static let viewModel: ViewModel = {
        let viewModel = ViewModel()
        viewModel.mockingSetup()
        return viewModel
    }()
    static var previews: some View {
        HomeView()
            .environmentObject(schoolAPI)
            .environmentObject(viewModel)
    }
}
