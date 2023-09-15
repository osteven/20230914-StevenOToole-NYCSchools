//
//  SchoolDetailView.swift
//  StevenOToole-NYCSchools
//
//  Created by Steven O'Toole on 9/14/23.
//

import SwiftUI
import MapKit

struct SchoolDetailView: View {
    let school: HighSchool
    private let satFont = Font.custom("", size: 14)
    private let satPad: CGFloat = 8
    @State var showEmailComposer = false

    var body: some View {
        StandardLayoutView {
            ScrollView {
                ZStack(alignment: .topLeading) {
                    Color.clear
                    VStack(alignment: .leading) {
                        Text(school.name)
                            .font(.largeTitle)
                            .foregroundColor(Color.Palette.teal)
                        if let email = school.email {
                            if EmailComposerView.canSend {
                                Button(
                                    action: sendEmail,
                                    label: {
                                        Image(systemName: "paperplane.fill")
                                            .frame(width: 32)
                                        Text(email)
                                    })
                                .padding(.top, 8)
                            } else {
                                Text(email)
                                    .padding(.top, 4)
                            }
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
                        if let sports = school.sports {
                            VStack(alignment: .leading) {
                                Text("Sports:").bold()
                                ScrollView(.horizontal, showsIndicators: true) {
                                    HStack(spacing: 32) {
                                        ForEach(sports.all) { item in
                                            VStack {
                                                Image(systemName: item.imageName)
                                                    .font(.system(size: 32))
                                                Text(item.rawValue).font(.caption)
                                            }
                                        }
                                    }
                                    .padding(.bottom, 16)
                                }
                                .padding(.leading, 16)
                            }
                            .background(
                                Color.Palette.teal
                                    .opacity(0.1)
                                    .scaleEffect(x: 1.1, y: 1.1)
                            )
                            .padding(.top, 16)
                        }
                        if let coordinate = school.coordinate {
                            MapView(coordinate: coordinate)
                                .padding(.top, 32)
                                .frame(idealHeight: 512)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.top, 32)
                .padding(.bottom, 256)
            }
        }
        .sheet(
            isPresented: $showEmailComposer,
            onDismiss: dismissMailComposer) {
                if let email = school.email {
                    EmailComposerView(recipient: email)
                }
            }
    }
    
    private func dismissMailComposer() { showEmailComposer = false }
    private func sendEmail() { showEmailComposer = true }
}

extension HighSchool {
    var coordinate: CLLocationCoordinate2D? {
        guard let latitude, let longitude else { return nil }
        return CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude)
    }
}

private struct MapView: View {
    private let coordinate: CLLocationCoordinate2D
    @State private var region: MKCoordinateRegion
     
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 750,
            longitudinalMeters: 750
        )
    }

    var body: some View {
        Map(
            coordinateRegion: $region,
            annotationItems: [SchoolPlace(coordinate: coordinate)]) { place in
            MapMarker(coordinate: place.location,
                      tint: Color.Palette.red)
        }
    }
}

private struct SchoolPlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.location = coordinate
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
