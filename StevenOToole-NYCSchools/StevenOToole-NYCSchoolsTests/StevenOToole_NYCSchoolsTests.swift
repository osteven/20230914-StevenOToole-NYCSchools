//
//  StevenOToole_NYCSchoolsTests.swift
//  StevenOToole-NYCSchoolsTests
//
//  Created by Steven O'Toole on 9/14/23.
//

import XCTest
import StevenOToole_NYCSchools

final class StevenOToole_NYCSchoolsTests: XCTestCase {
    private let decoder = JSONDecoder()

    func testDecodeSchools() throws {
       guard let data = HighSchool.mockJSON.data(using: .utf8) else {
           XCTAssert(false)
           return
       }
       let schools = try decoder.decode([HighSchool].self, from: data)
       XCTAssert(schools.count == 3)
       XCTAssert(schools[1].id == "21K728")
       XCTAssert(schools[2].name == "Women's Academy of Excellence")
  }

}
