//
//  MenuView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 03.05.2025.
//

import Foundation
import SwiftUI

struct MenuOption: Identifiable, Hashable {
    let id: String
    let title: String
    let icon: String
    let scenario: Scenario
    
    static var options: [MenuOption]  {
        Scenario.scenarios.compactMap{
            MenuOption(id: $0.id, title: $0.title, icon: $0.thumbnail, scenario: $0)
        }
    }
}

protocol ScenarioListViewModelProtocol: ObservableObject {
    var scenarios: [Scenario] { get }
    var selectedScenario: Scenario? { get set }
    func selectScenario(_ scenario: Scenario)
}

final class MenuScenarioListViewModel: ScenarioListViewModelProtocol {
    @Published private(set) var scenarios: [Scenario]
    @Published var selectedScenario: Scenario? = nil

    init(scenarios: [Scenario]) {
        self.scenarios = scenarios
    }

    func selectScenario(_ scenario: Scenario) {
        selectedScenario = scenario
    }
}

struct MenuScenarioCardView: View {
    let scenario: Scenario
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            Image(scenario.thumbnail)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .cornerRadius(10)

            Text(scenario.title)
                .font(.title2.bold())
                .foregroundStyle(.white)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)

            Spacer()

            Image(systemName: "heart")
                .foregroundStyle(.white)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.gray.opacity(0.4))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 3)
                )
        )
        .onTapGesture {
            onTap()
        }
        .padding(.horizontal)
        .hoverEffect()
    }
}

struct MenuScenarioListView<ViewModel: ScenarioListViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismiss) private var dismiss
    @Environment(\.dismissWindow) private var dismissWindow
    
    @State private var isScenarioBeingPresented: Bool = false
    
    @ViewBuilder
    private func TitleView() -> some View {
        VStack(spacing: 0) {
            Text("Welcome to SRay")
                .font(.largeTitle.bold())
                .foregroundStyle(.white)

            Text("Please Pick up a scenario")
                .font(.title2)
                .foregroundStyle(.white.opacity(0.9))
        }
    }
    
    @ViewBuilder
    private func ListView() -> some View {
        ForEach(viewModel.scenarios) { scenario in
            MenuScenarioCardView(
                scenario: scenario,
                isSelected: viewModel.selectedScenario == scenario
            ) {
                viewModel.selectScenario(scenario)
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView {
                VStack(spacing: 20) {
                    Spacer()
                        .frame(height: 10)
                    
                    TitleView()
                    ListView()
                }
            }

            Button("Start") {
                dismissWindow.callAsFunction(id: MRSignTranslateApp.WindowGroupIdentifiers.main)
                
                dismiss()
                
                openScenario()
                
            }
            .buttonStyle(.plain)
            .font(.title)
            .padding()
            .frame(width: 200, height: 60)
            .background(viewModel.selectedScenario != nil ? Color.blue : Color.gray.opacity(0.3))
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .disabled(viewModel.selectedScenario == nil)
            .hoverEffect()
        }
        .padding()
        .padding(.bottom, 20)
        .cornerRadius(40)
        .onChange(of: isScenarioBeingPresented) { oldValue, newValue in
            dismissWindow.callAsFunction(id: MRSignTranslateApp.WindowGroupIdentifiers.main)
        }
        .accessibilityLabel(Text("Menu with Scenarios"))
        .accessibilityValue(Text("Included Scenarios are: \(viewModel.scenarios.compactMap({ $0.title }))"))
    }
    
    private func openScenario() {
        if let scenario = self.viewModel.selectedScenario {
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
}

#Preview("ScenarioListView") {
    NavigationView {
        MenuScenarioListView(
            viewModel: MenuScenarioListViewModel(
                scenarios: Scenario.scenarios
            )
        )
        .layoutPriority(1)
    }
    .navigationViewStyle(.stack)
    .frame(width: 600)
    .frame(maxHeight: .infinity)
}
