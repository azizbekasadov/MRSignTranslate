//
//  MRSignTranslateApp.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import SwiftUI
import SwiftData
//import RealityKit
import MRSignMTKit
import MRSignMTArchitecture

@main
struct MRSignTranslateApp: App {
    private enum AppVersion {
        case largeMenu
        case listMenu
    }
    
    enum WindowGroupIdentifiers {
        static let main: String = "MRSignTranslate.MainWindowGroup.main"
        static let bubble: String = "MRSignTranslate.MainWindowGroup.bubble"
        static let captions: String = "MRSignTranslate.MainWindowGroup.captions"
        static let skeleton: String = "MRSignTranslate.MainWindowGroup.skeleton"
        static let avatar: String = "MRSignTranslate.MainWindowGroup.avatar"
        static let translator: String = "MRSignTranslate.MainWindowGroup.translator"
        static let privacy: String = "MRSignTranslate.MainWindowGroup.privacy"
        static let skeletonOnly: String = "MRSignTranslate.MainWindowGroup.skeletonOnly"
        
        static let allCases: [String] = [
            WindowGroupIdentifiers.main, WindowGroupIdentifiers.bubble, WindowGroupIdentifiers.captions, WindowGroupIdentifiers.skeleton, WindowGroupIdentifiers.avatar, WindowGroupIdentifiers.translator, WindowGroupIdentifiers.privacy
        ]
    }
    
    @StateObject private var router = MainRouter()
    @Environment(\.isSpatial) var isSpatial
    
    @State private var isShowMainView: Bool = true
    @State private var isCaptionsVisible: Bool = true
    @State private var isSkeletonVisible: Bool = true
    @State private var isSkeletonOnlyVisible: Bool = true
    @State private var isBubbleVisible: Bool = true
    
    private let dataStorageManager = DataStorageManager(
        container: .store()
    )
    
    init() {
        setupInjectionContainer()
    }
    
    @ViewBuilder
    private func MainSceneryView() -> some View {
        if isShowMainView {
            MainSplitView(
                isShowMainView: $isShowMainView,
                isCaptionsVisible: $isCaptionsVisible,
                isSkeletonVisible: $isSkeletonVisible,
                isSkeletonOnlyVisible: $isSkeletonOnlyVisible,
                isBubbleVisible: $isBubbleVisible
            )
        } // showing the main content view MainSplitView()
    }
    
    // drum chan man numme mit verschiidni versionän zsäme wächsle
    @ViewBuilder
    private func TabViewBuilder(
        _ version: AppVersion = .listMenu
    ) -> some View {
        switch version {
        case .largeMenu:
            MainSceneryView()
                .preferredColorScheme(.dark)
                .modelContainer(dataStorageManager.selectedContainer)
        case .listMenu:
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
            .preferredColorScheme(.dark)
            .modelContainer(dataStorageManager.selectedContainer)
        }
    }
    
    var body: some Scene {
        let tabType = AppVersion.listMenu
        let windowFrame = CGSize(
            width: tabType == .largeMenu ? 1200 : 600,
            height: tabType == .largeMenu ? 1000 : 800
        )
        
        WindowGroup(id: WindowGroupIdentifiers.main) {
            TabViewBuilder(tabType)
        }
        .windowResizability(.contentSize)
        .defaultSize(width: windowFrame.width, height: windowFrame.height)
        
        WindowGroup(id: WindowGroupIdentifiers.captions) {
            if isCaptionsVisible {
                Speech2CaptionsView(
                    showMainWindow: $isShowMainView,
                    isVisible: $isCaptionsVisible
                )
            }
        }
        .windowStyle(.plain)
        .defaultSize(width: 0.8, height: 0.8, depth: 0.8, in: .meters)
        .windowResizability(.contentSize)
        
        WindowGroup(id: WindowGroupIdentifiers.translator) {
            MRWebViewFactory.signMT()
        }
        .windowStyle(.plain)
        .defaultSize(width: 1, height: 1, depth: 1.2, in: .meters)
        .windowResizability(.contentSize)
        
        WindowGroup(id: WindowGroupIdentifiers.privacy) {
            PrivacyScreen()
        }
        .windowStyle(.automatic)
        .defaultSize(width: 1, height: 1, depth: 1.2, in: .meters)
        .windowResizability(.contentSize)
        
        /// Used for skeleton attached to the person scenario
        WindowGroup(id: WindowGroupIdentifiers.skeleton) {
            if self.isSkeletonVisible {
                SpeechBubbleWithSignMTView(
                    showMainWindow: $isShowMainView,
                    isVisible: $isSkeletonVisible
                )
            }
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1, height: 1, depth: 1.2, in: .meters)
        .windowResizability(.contentSize)
        
        WindowGroup(id: WindowGroupIdentifiers.skeletonOnly) {
            if self.isSkeletonOnlyVisible {
                SkeletonView(
                    showMainWindow: $isShowMainView,
                    isVisible: $isSkeletonOnlyVisible
                )
            }
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1, height: 1, depth: 1.2, in: .meters)
        .windowResizability(.contentSize)
        
        WindowGroup(id: WindowGroupIdentifiers.bubble, for: Bool.self) { isBubbleVisible in
            if self.isBubbleVisible {
                SpeechBubbleView(
                    showMainWindow: $isShowMainView,
                    isVisible: $isBubbleVisible
                )
            }
        }
        .windowStyle(.plain)
        .defaultSize(width: 1, height: 1, depth: 1.2, in: .meters)
        .windowResizability(.contentSize)
        
        ImmersiveSpace(id: WindowGroupIdentifiers.avatar, for: Bool.self) { isBubbleImmersiveSceneVisible in
            MRBubbleImmersiveSceneView()
        }
        .windowStyle(.volumetric)
     }
}

private extension MRSignTranslateApp {
    func setupInjectionContainer() {
        InjectionContainer.register(type: DataStorageManager.self, as: .singleton, dataStorageManager)
        InjectionContainer.register(type: MainRouter.self, as: .singleton, router)
        InjectionContainer.register(type: SettingsRouter.self, as: .singleton, SettingsRouter())
        InjectionContainer.register(type: UserRepository.self, UserRepositoryImpl())
        InjectionContainer.register(type: RemoteRepository.self, RemoteRepositoryImpl())
        InjectionContainer.register(type: EmailServiceProtocol.self, EmailService())
    }
}
