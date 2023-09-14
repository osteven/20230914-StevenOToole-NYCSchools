//
//  NYCSchoolAPI.swift
//  StevenOToole-NYCSchools
//
//  Created by Steven O'Toole on 9/14/23.
//

import Foundation
import OSLog

// MARK: - NYCSchoolAPI

public final class NYCSchoolAPI: ObservableObject {
    public func getSchools(completion: @escaping (Result<[HighSchool], Swift.Error>) -> Void) {
        guard let url = urlFor(endPoint: .schools)
        else {
            completion(.failure(URLSession.Error.invalidURL(Endpoint.schools.path)))
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.activateDataTask(request: request, completion: completion)
    }
    
    public func getScores(completion: @escaping (Result<[SATScore], Swift.Error>) -> Void) {
        guard let url = urlFor(endPoint: .scores)
        else {
            completion(.failure(URLSession.Error.invalidURL(Endpoint.scores.path)))
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.activateDataTask(request: request, completion: completion)
    }
}

private extension NYCSchoolAPI {
    func urlFor(endPoint: Endpoint) -> URL? {
        guard var components = URLComponents(string: endPoint.path) else {
            // This will notify us only if there's a problem in development.
            assertionFailure("ERROR, path: \(endPoint.path)")
            return nil
        }
        
        // Normally I would append URLQueryItem parameters here. But this API doesn't need them.
        components.queryItems = []
        return components.url
    }
}

// MARK: - NYCSchoolAPI Endpoints

/// Provides a path string for resources.
private enum Endpoint {
    private static let baseURL = "https://data.cityofnewyork.us/resource"
    case schools
    case scores

    var path: String {
        switch self {
        case .schools: return "\(Self.baseURL)/s3k6-pzi2.json"
        case .scores: return "\(Self.baseURL)/f9bf-2cp4.json"
        }
    }
}
