//
//  SATScore.swift
//  StevenOToole-NYCSchools
//
//  Created by Steven O'Toole on 9/14/23.
//

import Foundation

// MARK: - SATScore

public struct SATScore: Decodable {
    public let id: String
    public let name: String
    public let numberOfTakers: Int?
    public let readingAvg: Int?
    public let mathAvg: Int?
    public let writingAvg: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "dbn"
        case name = "school_name"
        case numberOfTakers = "num_of_sat_test_takers"
        case readingAvg = "sat_critical_reading_avg_score"
        case mathAvg = "sat_math_avg_score"
        case writingAvg = "sat_writing_avg_score"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        if let takersString = try container.decodeIfPresent(String.self, forKey: .numberOfTakers) { numberOfTakers = Int(takersString)
        } else {
            numberOfTakers = nil
        }
        if let readingString = try container.decodeIfPresent(String.self, forKey: .readingAvg) {
            readingAvg = Int(readingString)
        } else {
            readingAvg = nil
        }
        if let mathString = try container.decodeIfPresent(String.self, forKey: .mathAvg) {
            mathAvg = Int(mathString)
        } else {
            mathAvg = nil
        }
        if let writingString = try container.decodeIfPresent(String.self, forKey: .writingAvg) {
            writingAvg = Int(writingString)
        } else {
            writingAvg = nil
        }
    }
}

// MARK: - Mock

#if DEBUG
extension SATScore {
    public static var mockJSON: String { """
[{
  "dbn": "21K728",
  "num_of_sat_test_takers": "10",
  "sat_critical_reading_avg_score": "411",
  "sat_math_avg_score": "369",
  "sat_writing_avg_score": "373",
  "school_name": "LIBERATION DIPLOMA PLUS"
},
{
  "dbn": "08X282",
  "num_of_sat_test_takers": "44",
  "sat_critical_reading_avg_score": "407",
  "sat_math_avg_score": "386",
  "sat_writing_avg_score": "378",
  "school_name": "WOMEN'S ACADEMY OF EXCELLENCE"
}]
"""
    }
}
#endif
