//
//  SchoolDetailView.swift
//  StevenOToole-NYCSchools
//
//  Created by Steven O'Toole on 9/14/23.
//

import SwiftUI

struct SchoolDetailView: View {
    let school: HighSchool
    private let satFont = Font.custom("", size: 14)
    private let satPad: CGFloat = 8

    var body: some View {
        StandardLayoutView {
            ScrollView {
                ZStack(alignment: .topLeading) {
                    Color.clear
                    VStack(alignment: .leading) {
                        Text(school.name)
                            .font(.largeTitle)
                        if let email = school.email {
                            Text(email)
                        }
                        Text(school.overviewParagraph)
                            .font(.callout).italic()
                            .padding(.top, 16)
                        if let scores = school.scores {
                            HStack(alignment: .lastTextBaseline) {
                                Text("Scores:").bold()
                                if let reading = scores.readingAvg {
                                    Text("Reading: \(reading)").font(satFont)
                                        .padding(.leading, satPad)
                                }
                                if let math = scores.mathAvg {
                                    Text("Math: \(math)").font(satFont)
                                        .padding(.leading, satPad)
                                }
                                 if let writing = scores.writingAvg {
                                    Text("Writing: \(writing)").font(satFont)
                                        .padding(.leading, satPad)
                                }
                                Spacer()
                            }
                            .padding(.top, 16)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 32)
                }
            }
        }
    }
}

// MARK: - Previews

struct SchoolDetailView_Previews: PreviewProvider {
    private static let school: HighSchool = {
        HighSchool()
    }()
    static var previews: some View {
        SchoolDetailView(school: school)
    }
}
