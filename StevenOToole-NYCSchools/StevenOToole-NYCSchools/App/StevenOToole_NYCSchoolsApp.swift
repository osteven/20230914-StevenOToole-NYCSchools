//
//  StevenOToole_NYCSchoolsApp.swift
//  StevenOToole-NYCSchools
//
//  Created by Steven O'Toole on 9/14/23.
//

import SwiftUI

@main
struct StevenOToole_NYCSchoolsApp: App {
    private let schoolAPI = NYCSchoolAPI()

    var body: some Scene {
        WindowGroup {
            HomeView(schoolAPI: schoolAPI)
        }
    }
}
