//
//  Sports.swift
//  StevenOToole-NYCSchools
//
//  Created by Steven O'Toole on 9/14/23.
//

import Foundation

/// This is an enum representing each Sport. A school can offer many sports.
/// Note: There are more sports than this. I didn't handle them all. Probably it would have
/// better to make Sport a struct rather than an enum..
/// Also Note: This might be too fragile. In a real app, I should have used init(from decoder: Decoder)
/// in case of differences in capitalization, etc.
public enum Sport: String, Decodable, Identifiable {
    case crossCountry = "Cross Country"
    case trackAndField = "Track and Field"
    case soccer = "Soccer"
    case flagFootball = "Flag Football"
    case basketball = "Basketball"
    case baseball = "Baseball"
    case fencing = "Fencing"
    case stunt = "Stunt"
    case indoorTrack = "Indoor Track"
    case outdoorTrack = "Outdoor Track"
    case softball = "Softball"
    case volleyball = "Volleyball"
    case swimming = "Swimming"
    case cricket = "Cricket"
    case doubleDutch = "Double Dutch"
    case football = "Football"
    case wrestling = "Wrestling"
    case tennis = "Tennis"
    case cheerleading = "Cheerleading"
    case bowling = "Bowling"

    public var id: String {
        self.rawValue
    }
    
    public var imageName: String {
        switch self {
        case .crossCountry: return "figure.run"
        case .trackAndField, .indoorTrack, .outdoorTrack: return "figure.track.and.field"
        case .soccer: return "soccerball"
        case .flagFootball, .football: return "football"
        case .basketball: return "basketball"
        case .baseball, .softball: return "baseball"
        case .fencing: return "figure.fencing"
        case .volleyball: return "volleyball"
        case .swimming: return "figure.pool.swim"
        case .cricket: return "cricket.ball"
        case .doubleDutch: return "figure.jumprope"
        case .wrestling: return "figure.wrestling"
        case .tennis: return "tennis.racket"
        case .bowling: return "figure.bowling"
            //  Use this as a generic icon
        default: return "figure.wave"
        }
    }
}


// Sports are passed in `school_sports`,  `psal_sports_boys`,` psal_sports_coed`, `psal_sports_girls`
// Note: I got most of the sports but not all.
public struct Sports: Decodable {
    public let all: [Sport]
    
    public init(all: [Sport]) {
        self.all = all
    }
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        let string = try value.decode(String.self)
        var sports = [Sport]()
        let rawArray = string.components(separatedBy: ", ")
        for item in rawArray {
            guard let sport = Sport(rawValue: item.trimmingCharacters(in: .whitespaces)) else {
                // Issue some kind of log if something unexpected happens in production
                #if DEBUGLOG
                Logger.parsing.warning("Missing sport: \(item)")
                #endif
                continue
            }
            sports.append(sport)
        }
        self.all = sports
    }
}
