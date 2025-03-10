//
//  ScenariosView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import SwiftUI
import MRSignMTArchitecture

extension Scenario {
    static let scenarios: [Scenario] = [
        Scenario(
            id: UUID(),
            title: "Mix fear and fishing in dredge",
            thumbnail: "mocks/scenario/chip_bg",
            backgroundImage: "dredge_bg",
            level: .easy,
            description: "Catch strange fish while evading horrors at sea.",
            instructions: ["Step 1", "Step 2"],
            localizedStringResource: "NEW GAME"
        ),
        Scenario(
            id: UUID(),
            title: "Warp Your Reality in Control",
            thumbnail: "mocks/scenario/chip_bg",
            backgroundImage: "control_bg",
            level: .medium,
            description: "Unleash supernatural powers in this action-adventure thriller.",
            instructions: ["Step 1", "Step 2"],
            localizedStringResource: "PRE-ORDER"
        ),
        Scenario(
            id: UUID(),
            title: "Throw a gift hunt in Gardenscapes!",
            thumbnail: "mocks/scenario/chip_bg",
            backgroundImage: "gardenscapes_bg",
            level: .hard,
            description: "Surprise the spies and earn some winter rewards.",
            instructions: ["Step 1", "Step 2"],
            localizedStringResource: "LIMITED TIME"
        )
    ]
}

struct ScenariosView: View {
    private let scenarios = Scenario.scenarios
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.flexible())], spacing: 16) {
                        ForEach(scenarios) { scenario in
                            ScenarioCardView(scenario: scenario)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: geometry.size.height, alignment: .top)
            }
            .frame(minHeight: 250, alignment: .top)
        }
        Spacer()
    }
}

#Preview(body: {
    ScenariosView()
        .frame(minHeight: 700)
        .background(.gray)
})

