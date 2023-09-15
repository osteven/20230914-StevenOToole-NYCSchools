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
    static let email = Logger(subsystem: appIdentifier, category: "email")
    static let model = Logger(subsystem: appIdentifier, category: "model")
}
