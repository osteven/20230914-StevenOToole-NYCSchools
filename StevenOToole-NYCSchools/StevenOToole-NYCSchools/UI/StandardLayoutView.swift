//
//  StandardLayoutView.swift
//  StevenOToole-NYCSchools
//
//  Created by Steven O'Toole on 9/14/23.
//

import SwiftUI

struct StandardLayoutView<Destination: View>: View {
    @ViewBuilder let destination: () -> Destination
    var body: some View {
        ZStack {
            StandardBackgroundView()
            destination()
        }
    }
}

private struct StandardBackgroundView: View {
    var body: some View {
        LinearGradient(
            colors: [.teal.opacity(0.02), .teal.opacity(0.05), .teal.opacity(0.5)],
            startPoint: .top,
            endPoint: .bottom
        )
        .opacity(0.5)
        .edgesIgnoringSafeArea(.bottom)
    }
}
