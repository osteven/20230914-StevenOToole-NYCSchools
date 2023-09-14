//
//  Logger+Extensions.swift
//  StevenOToole-NYCSchools
//
//  Created by Steven O'Toole on 9/14/23.
//

import OSLog

extension Logger {
    private static let appIdentifier = Bundle.main.bundleIdentifier ?? "NYC"
    static let api = Logger(subsystem: appIdentifier, category: "api")
}