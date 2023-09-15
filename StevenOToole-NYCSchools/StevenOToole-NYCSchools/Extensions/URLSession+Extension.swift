//
//  URLSession+Extension.swift
//  StevenOToole-NYCSchools
//
//  Created by Steven O'Toole on 9/14/23.
//

import Foundation

// MARK: - URLSession Extensions

extension URLSession {
    public enum Error: Swift.Error, CustomStringConvertible, CustomNSError {
        case failedStatusCode(Int)
        case notHTTP
        case noData
        case unexpected
        case invalidURL(String)

        public var description: String {
            switch self {
            case .failedStatusCode(let code): return "failedStatusCode: \(code)"
            case .notHTTP: return "Unexpected non-HTTP response"
            case .noData: return "Unexpected nil data in response"
            case .unexpected: return "Unexpected nil data in response"
            case .invalidURL(let urlString): return "Bad URL: \(urlString)"
            }
        }

        public var errorCode: Int {
            switch self {
            case .failedStatusCode: return -1
            case .notHTTP: return -2
            case .noData: return -3
            case .unexpected: return -4
            case .invalidURL: return -5
            }
        }
    }
    
    public func activateDataTask<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Swift.Error>) -> Void) {
        activateDataTask(request: request) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success((let httpResponse, let data)):
                do {
                    try self.validateHTTP(response: httpResponse)
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    @discardableResult
    private func validateHTTP(response: HTTPURLResponse) throws -> Int {
        guard 200...299 ~= response.statusCode || 400...499 ~= response.statusCode else {
            throw Error.failedStatusCode(response.statusCode)
        }
        return response.statusCode
    }

    func activateDataTask(request: URLRequest, completion: @escaping (Result<(HTTPURLResponse, Data), Swift.Error>) -> Void) {
        dataTask(with: request) { data, urlResponse, error in
            switch (data, urlResponse, error) {
            case let (_, _, error?):
                completion(.failure(error))
            case let (data, urlResponse, nil):
                guard let httpResponse = urlResponse as? HTTPURLResponse else {
                    completion(.failure(Error.notHTTP))
                    return
                }
                guard let data else {
                    completion(.failure(Error.noData))
                    return
                }
                completion(.success((httpResponse, data)))
            }
        }.resume()
    }
}
