//
//  HomeView.swift
//  StevenOToole-NYCSchools
//
//  Created by Steven O'Toole on 9/14/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            IntroView()
                .opacity(viewModel.currentSelection.isEmpty ? 1.0 : 0.0)
                .animation(.easeInOut, value: viewModel.currentSelection.isEmpty)
            
            NavigationStack {
                SchoolListView()
                    .navigationTitle("NYC High Schools")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .opacity(viewModel.currentSelection.isEmpty ? 0.0 : 1.0)
            .animation(.easeInOut, value: viewModel.currentSelection.isEmpty)
        }
    }
}

private struct IntroView: View {
    @EnvironmentObject var schoolAPI: NYCSchoolAPI
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
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
                .disabled(viewModel.loading)
                Image(systemName: "graduationcap.fill")
                    .resizable()
                    .foregroundColor(.Palette.teal)
                    .frame(width: 128, height: 128)
                    .rotationEffect(viewModel.loading ? .degrees(360) : .zero)
                    .animation(.easeInOut, value: viewModel.loading)
                    .padding(.top, 32)
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
        List {
            ForEach(viewModel.currentSelection) { item in
                NavigationLink {
                    SchoolDetailView(school: item)
                } label: {
                    SchoolListCellView(item: item)
                }
            }
            .listRowBackground(Color.Palette.teal.opacity(0.2))
        }
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
            HStack(alignment: .lastTextBaseline) {
                Text(item.borough.description).font(.caption).bold()
                if let best = item.scores?.bestScore {
                    Spacer()
                    Text("Best SAT: \(best.0) \(best.1)")
                        .frame(alignment: .trailing)
                        .font(.caption2)
                    
                } else {
                    Spacer()
                }
            }
            .padding(.top, 8)
            .padding(.bottom, 4)
            .padding(.horizontal, 8)
        }
        .frame(minHeight: 64)
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
