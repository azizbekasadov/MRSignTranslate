//
//  ScenarioCardView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import SwiftUI

struct ScenarioCardView: View {
    let scenario: Scenario
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(scenario.thumbnail)
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 200)
                .cornerRadius(6, corners: .allCorners)
                .clipped()
            
            Text(scenario.level.rawValue.uppercased())
                .font(.caption)
                .fontWeight(.bold)
                .lineLimit(nil)
                .foregroundColor(.gray)
                .padding(.top, 4)
            
            Text(scenario.title)
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(nil)
                .padding(.top, 2)
            
            Text(scenario.description)
                .font(.subheadline)
                .lineLimit(nil)
                .foregroundColor(.secondary)
                .layoutPriority(0)
            Spacer()
        }
        .frame(width: 300, alignment: .top)
        .background(Color.white.opacity(0.001))
        .padding(10)
        .cornerRadius(6, corners: .allCorners)
        .hoverEffect(.lift)
    }
}

#Preview {
    ScenarioCardView(scenario: .scenarios[0])
}
