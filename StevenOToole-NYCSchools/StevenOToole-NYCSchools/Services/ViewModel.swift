//
//  ViewModel.swift
//  StevenOToole-NYCSchools
//
//  Created by Steven O'Toole on 9/14/23.
//

import SwiftUI

// MARK: - ViewModel

// Note: In this app I am not going to worry about thread contention to the data. In a real app,
// I would protect access by means of a concurrent barrier thread or Actors.
public class ViewModel: ObservableObject {
    private(set) var schoolDictionary = [DBNIdentifier: HighSchool]()
    @Published var currentSelection = [HighSchool]()
    
    public init() {}
    
    public func load(with api: NYCSchoolAPI) {
        loadSchools(with: api)
    }
    
    public func school(for id: DBNIdentifier) -> HighSchool? {
        schoolDictionary[id]
    }
    
    public func set(schools: [DBNIdentifier: HighSchool]) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            schoolDictionary = schools
            currentSelection = [HighSchool]()
            currentSelection.append(contentsOf: schoolDictionary.values)
       }
    }
}

// MARK: - Private implementation

extension ViewModel {
    private func loadSchools(with api: NYCSchoolAPI) {
        api.getSchools { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let schools):
//                print("🟢 \(schools.count)")
//                for school in schools {
//                    print("\t\(school.id) \(school.name);  \(school.borough)")
//                }
                loadScores(with: api, into: schools)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadScores(with api: NYCSchoolAPI, into schools: [HighSchool]) {
        api.getScores { [weak self] result in
            switch result {
            case .success(let allScores):
                guard let self else { return }
                var schoolDictionary = Dictionary(uniqueKeysWithValues: schools.map { ($0.id, $0) })
                // do this with compactmap?
                for score in allScores {
                    guard var school = schoolDictionary[score.id] else {
                        print("unmatched score: \(score)")
                        continue
                    }
                    school.scores = score
                    schoolDictionary[score.id] = school
                }
                set(schools: schoolDictionary)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - This is just for the tests

#if DEBUG
extension ViewModel {
    public func dump() {
        print("🟠 SCHOOLS")
        for school in currentSelection {
            print("\t\(school.id) \(school.name)")
        }
    }
    
    public func mockingSetup() {
        guard let scoresData = SATScore.mockJSON.data(using: .utf8) else {
            assertionFailure()
            return
        }
        let decoder = JSONDecoder()
        do {
            let scores = try decoder.decode([SATScore].self, from: scoresData)
            guard let schoolData = HighSchool.mockJSON.data(using: .utf8) else {
                assertionFailure()
                return
            }
            let schools = try decoder.decode([HighSchool].self, from: schoolData)
            load(from: schools, with: scores)
        } catch {
            assertionFailure("\(error)")
        }
    }
    
    public func load(from schools: [HighSchool], with scores: [SATScore]) {
        var schoolDictionary = Dictionary(uniqueKeysWithValues: schools.map { ($0.id, $0) })
        for score in scores {
            guard var school = schoolDictionary[score.id] else {
                print("unmatched score: \(score)")
                continue
            }
            school.scores = score
            schoolDictionary[score.id] = school
        }
        set(schools: schoolDictionary)
    }
}
#endif
