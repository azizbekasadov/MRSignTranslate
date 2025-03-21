//
//  ScenariosView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import SwiftUI
import MRSignMTArchitecture

struct ScenariosView: View {
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.openWindow) private var openWindow
    
    @State private var isScenarioTapped: Bool = false
    @State private var selectedScenario: Scenario?
    
    private let scenarios = Scenario.scenarios
    private let quickLinks = QuickLinkItem.links
    private let options = [
        [
            ScenarioSmallRectItem.options[0],
            ScenarioSmallRectItem.options[1]
        ],
        [
            ScenarioSmallRectItem.options[2],
            ScenarioSmallRectItem.options[3]
        ]
    ]
    
    @ViewBuilder
    private func MainGridView() -> some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 5) {
                    ForEach(scenarios) { scenario in
                        ScenarioCardView(scenario: scenario)
                            .onTapGesture {
                                isScenarioTapped = true
                                selectedScenario = scenario
                            }
                    }
                }
                
                Spacer()
            }
            .padding(6)
            .frame(minHeight: 250, alignment: .top)
        }
        .alert(
            selectedScenario?.title ?? "Scenario",
            isPresented: $isScenarioTapped) {
                // Start
                Button("Start") {
                    // start scenario
                }
                Button("Cancel") {}
            }
    }
    
    @ViewBuilder
    private func QuickLinksView() -> some View {
        VStack(alignment: .leading) {
            Text("Quick Links")
                .font(.headline)
            
            ForEach(quickLinks) { quickLink in
                SingleLineButton(
                    title: quickLink.title
                )
            }
            .padding(.leading, -6)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func SmallCardsGridView() -> some View {
        ScrollView(.horizontal) {
            VStack(alignment: .leading) {
                Text("More Features")
                    .font(.headline)
                
                HStack(alignment: .top) {
                    VStack {
                        ScenarioSmallRectView(item: ScenarioSmallRectItem.options[0])
                        ScenarioSmallRectView(item: ScenarioSmallRectItem.options[1])
                    }
                    
                    VStack {
                        ScenarioSmallRectView(item: ScenarioSmallRectItem.options[2])
                        ScenarioSmallRectView(item: ScenarioSmallRectItem.options[3])
                    }
                    
                    VStack(alignment: .leading) {
                        ScenarioSmallRectView(item: ScenarioSmallRectItem.options[4])
                        ScenarioSmallRectView(item: ScenarioSmallRectItem.options[4])
                            .opacity(0)
                            .disabled(true)
                    }
                    
                    Spacer()
                }
            }
            .padding(.horizontal)
        }
        .scrollBounceBehavior(.basedOnSize)
    }
    
    var body: some View {
        ScrollView {
            VStack(
                alignment: .leading,
                spacing: 10
            ) {
                MainGridView()
                Divider()
                    .padding(.horizontal)
                SmallCardsGridView()
                Divider()
                    .padding(.horizontal)
                QuickLinksView()
                Spacer()
                    .frame(minHeight: 50)
            }
            .padding(.horizontal, 6)
        }
    }
}

#Preview(body: {
    NavigationStack {
        ScenariosView()
            .navigationTitle("Scenarios")
    }
})

