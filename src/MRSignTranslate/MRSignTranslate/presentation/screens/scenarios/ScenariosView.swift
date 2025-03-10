//
//  ScenariosView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import SwiftUI
import MRSignMTArchitecture

struct ScenariosView: View {
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
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                    ForEach(scenarios) { scenario in
                        ScenarioCardView(scenario: scenario)
                            .onTapGesture {
                                isScenarioTapped = true
                                selectedScenario = scenario
                            }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
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
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func SmallCardsGridView() -> some View {
        VStack(alignment: .leading) {
            Text("More Features")
                .font(.headline)
            
            HStack {
                VStack {
                    ScenarioSmallRectView(item: ScenarioSmallRectItem.options[0])
                    ScenarioSmallRectView(item: ScenarioSmallRectItem.options[1])
                }
                
                VStack {
                    ScenarioSmallRectView(item: ScenarioSmallRectItem.options[2])
                    ScenarioSmallRectView(item: ScenarioSmallRectItem.options[3])
                }
                
                VStack {
                    ScenarioSmallRectView(item: ScenarioSmallRectItem.options[4])
                    Spacer()
                }
                
                Spacer()
            }
//
//            TabView {
////                ForEach(0..<options.count, id: \.self) { index in
//////                    VStack {
//////                        ForEach(options[index], id: \.id) { subitem in
//////                            ScenarioSmallRectView(item: subitem)
//////                        }
//////                    }
//////                    .padding(.horizontal)
////                    ScenarioSmallRectView(item: ScenarioSmallRectItem.options[0])
////                    ScenarioSmallRectView(item: ScenarioSmallRectItem.options[1])
////                }
//                ScenarioSmallRectView(item: ScenarioSmallRectItem.options[0])
//                ScenarioSmallRectView(item: ScenarioSmallRectItem.options[1])
//            }
//            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .padding(.horizontal)
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
        }
    }
}

#Preview(body: {
    NavigationStack {
        ScenariosView()
            .navigationTitle("Scenarios")
    }
})

