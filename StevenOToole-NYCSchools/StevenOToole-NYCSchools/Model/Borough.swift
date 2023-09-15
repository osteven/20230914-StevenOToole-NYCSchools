//
//  Borough.swift
//  StevenOToole-NYCSchools
//
//  Created by Steven O'Toole on 9/14/23.
//

import Foundation

public enum Borough: String, Decodable {
    case manhattan
    case brooklyn
    case bronx
    case queens
    case statenIsland = "staten is"
    case unknown

    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        let string = try value.decode(String.self)
        guard let borough = Borough(rawValue: string.lowercased().trimmingCharacters(in: .whitespaces)) else {
            throw BoroughError.notFound("\(string.lowercased())")
        }
        self = borough
    }
    
    enum BoroughError: Error {
        case notFound(String)
    }
    
    /// This is a backup mechanism for JSON records that are missing the `borough` key. Some seem to have `boro` with one letter instead.
    static func decodeFrom(abbreviation: String?) -> Borough {
        guard let abbreviation else { return .unknown }
        switch abbreviation {
        case "M": return .manhattan
        default: return .unknown
        }
    }
}

extension Borough: CustomStringConvertible {
    public var description: String {
        switch self {
        case .statenIsland: return "Staten Island"
        default: return self.rawValue.capitalized
        }
    }
}
