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
        if viewModel.currentSelection.isEmpty {
            ZStack(alignment: .top) {
                Color.clear
                VStack {
                    Text("Welcome to NYC High Schools")
                        .font(.title2)
                        .padding(.top, 32)
                        .padding()
                    Button(action: apiAction, label: {
                        VStack {
                            Text("Touch here to load")
                                .font(.callout)
                                .padding(.bottom, 2)
                            Text("(it will take a few seconds)")
                                .font(.caption)
                        }
                    })
                    Image(systemName: "graduationcap.fill")
                        .resizable()
                        .foregroundColor(.Palette.teal)
                        .frame(width: 128, height: 128)
                        .padding(.top, 32)
                }
            }
        } else {
            NavigationStack {
                SchoolListView()
                    .navigationTitle("NYC High Schools")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    private func apiAction() {
        viewModel.load(with: schoolAPI)
     }
}


private struct SchoolListView: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
            List(viewModel.currentSelection) { item in
                NavigationLink {
                    SchoolDetailView()
                } label: {
                    SchoolListCellView(item: item)
                }
            }
            .background(Color.clear)
            .listStyle(.plain)
    }
}

private struct SchoolDetailView: View {
    var body: some View {
        Color.Palette.red
    }
}

private struct SchoolListCellView: View {
    let item: HighSchool
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("\(item.name)")
                    .padding(.horizontal, 8)
                    .padding(.top, 8)
                    .frame(alignment: .leading)
                Spacer()
            }
            if let best = item.scores?.bestScore {
                HStack(alignment: .lastTextBaseline) {
                    Spacer()
                    Text("Best SAT: \(best.0) \(best.1)")
                        .frame(alignment: .trailing)
                        .font(.caption2)
                }
                .padding(8)
            } else {
                Spacer()
            }
        }
        .frame(minHeight: 64)
        .background(Color.Palette.red.opacity(0.1).cornerRadius(8))
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
