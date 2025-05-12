//
//  ScenariosView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import SwiftUI
import MRSignMTArchitecture
import MRSignMTKit

protocol ScenarioSmallViewFactory {
    func makeView(for item: ScenarioSmallRectItem) -> AnyView
}

struct DefaultScenarioViewFactory: ScenarioSmallViewFactory {
    func makeView(for item: ScenarioSmallRectItem) -> AnyView {
        switch item.type {
        case .translator:
            return MRWebViewFactory
                .signMT()
                .anyView
        case .dictionary:
            return EmptyView().anyView
        case .instructions:
            return EmptyView().anyView
        case .statistics:
            return EmptyView().anyView
        case .feedback:
            return EmptyView().anyView
        }
    }
}

@Observable
final class ScenariosViewModel {
    @ObservationIgnored
    private(set) var factory = DefaultScenarioViewFactory()
    
    private(set) var quickLinks:[QuickLinkItem] = []
    private(set) var options:[[ScenarioSmallRectItem]] = []
    private(set) var scenarios:[Scenario] = []
    
    @ObservationIgnored
    private let dataProvider: (any ScenarioDataProviderProtocol)
    
    init(dataProvider: any ScenarioDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    func fetchData() async {
        Task {
            scenarios = dataProvider.retrieveScenarios()
            options = dataProvider.retrieveSmallCardItems()
            quickLinks = dataProvider.retrievewQuickLinks()
        }
    }
}

struct ScenariosView: View {
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.openWindow) private var openWindow
    
    @State private var isScenarioTapped: Bool = false
    @State private var isScenarioLaunched: Bool = false
    @State private var selectedScenario: Scenario?
    @State private var selectedSmallScenarioType: ScenarioSmallRectItem? = nil
    @State private var showSheet: Bool = false
    
    // required for
    @Binding private var isShowMainView: Bool
    @Binding private var isCaptionsVisible: Bool
    @Binding private var isSkeletonVisible: Bool
    @Binding private var isSkeletonOnlyVisible: Bool
    @Binding private var isBubbleVisible: Bool
    
    private let viewModel = ScenariosViewModel(
        dataProvider: ScenariosDataProvider()
    )
    
    init(
        isShowMainView: Binding<Bool>,
        isCaptionsVisible: Binding<Bool>,
        isSkeletonVisible: Binding<Bool>,
        isSkeletonOnlyVisible: Binding<Bool>,
        isBubbleVisible: Binding<Bool>
    ) {
        self._isShowMainView = isShowMainView
        self._isCaptionsVisible = isCaptionsVisible
        self._isSkeletonVisible = isSkeletonVisible
        self._isSkeletonOnlyVisible = isSkeletonOnlyVisible
        self._isBubbleVisible = isBubbleVisible
    }
    
    @ViewBuilder
    private func MainGridView() -> some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 5) {
                    ForEach(viewModel.scenarios) { scenario in
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
                    openScenario()
                }
                Button("Cancel") {}
            }
    }
    
    private func openScenario() {
        if let scenario = self.selectedScenario {
            if scenario.isImmersiveWindow {
                Task {
                    await openImmersiveSpace.callAsFunction(
                        id: scenario.scenarioWindowId
                    )
                }
            } else {
                openWindow.callAsFunction(
                    id: scenario.scenarioWindowId
                )
            }
        }
    }
    
    @ViewBuilder
    private func QuickLinksView() -> some View {
        VStack(alignment: .leading) {
            Text("Quick Links")
                .font(.headline)
            
            ForEach(viewModel.quickLinks) { quickLink in
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
        let columns = ScenarioSmallRectItem.options.chunked(into: 2)

        ScrollView(.horizontal) {
            VStack(alignment: .leading, spacing: 12) {
                Text("More Features")
                    .font(.headline)

                HStack(alignment: .top, spacing: 16) {
                    ForEach(Array(columns.enumerated()), id: \.offset) {
                        index,
                        columnItems in
                        VStack(spacing: 12) {
                            ForEach(columnItems.indices, id: \.self) { innerIndex in
                                ScenarioSmallRectView(
                                    item: columnItems[innerIndex]
                                ) {
                                    let selected = columnItems[innerIndex]
                                    if selected.type == .translator {
                                        openWindow.callAsFunction(
                                            id: MRSignTranslateApp.WindowGroupIdentifiers.translator
                                        )
                                    } else {
                                        selectedSmallScenarioType = selected
                                    }
                                }
                            }
                            if columnItems.count == 1 {
                                ScenarioSmallRectView(item: columnItems[0]) {
                                    selectedSmallScenarioType = columnItems[0]
                                }
                                .opacity(0)
                                .disabled(true)
                            }
                        }
                    }

                    Spacer()
                }
            }
            .padding(.horizontal)
        }
        .scrollBounceBehavior(.basedOnSize)
        .sheet(isPresented: $showSheet) {
            if let type = selectedSmallScenarioType {
                viewModel.factory.makeView(for: type)
            }
        }
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
        .task {
            await viewModel.fetchData()
        }
    }
}

#Preview(
    body: {
        NavigationStack {
            ScenariosView(
                isShowMainView: .constant(true),
                isCaptionsVisible: .constant(false),
                isSkeletonVisible: .constant(false),
                isSkeletonOnlyVisible: .constant(false),
                isBubbleVisible: .constant(false)
            )
            .navigationTitle("Scenarios")
    }
})

