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
    
    private let dataStorageManager = DataStorageManager(
        container: .store()
    )
    
    init() {
        setupInjectionContainer()
    }
    
    @ViewBuilder
    private func MainSceneryView() -> some View {
            MainSplitView()
    }
    
    @ViewBuilder
    private func TabViewBuilder() -> some View {
        MainSceneryView()
            .preferredColorScheme(.dark)
            .modelContainer(dataStorageManager.selectedContainer)
    }
    
    var body: some Scene {
        WindowGroup {
            MainSceneryView()
        }
        .windowResizability(.contentSize)
        
        WindowGroup(id: WindowGroupIdentifiers.captions) {
            Speech2CaptionsView()
        }
        .windowStyle(.plain)
        .defaultSize(width: 0.8, height: 0.8, depth: 0.8, in: .meters)
        .windowResizability(.contentSize)
        
        WindowGroup(id: WindowGroupIdentifiers.translator) {
            MRWebViewFactory.signMT()
        }
        .windowStyle(.plain)
        .defaultSize(width: 0.8, height: 0.8, depth: 0.8, in: .meters)
        .windowResizability(.contentSize)
        
        WindowGroup(id: WindowGroupIdentifiers.privacy) {
            PrivacyScreen()
        }
        .windowStyle(.automatic)
        .defaultSize(width: 0.8, height: 0.8, depth: 0.8, in: .meters)
        .windowResizability(.contentSize)
        
        /// Used for skeleton attached to the person scenario
        WindowGroup(id: WindowGroupIdentifiers.skeleton) {
            SpeechBubbleWithSignMTView()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1, height: 1, depth: 1.2, in: .meters)
        .windowResizability(.contentSize)
        
        WindowGroup(id: WindowGroupIdentifiers.skeletonOnly) {
            SkeletonView()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.8, height: 0.8, depth: 0.8, in: .meters)
        .windowResizability(.contentSize)
        
        WindowGroup(id: WindowGroupIdentifiers.bubble) {
            SpeechBubbleView()
        }
        .windowStyle(.plain)
        .defaultSize(width: 1.5, height: 1.1, depth: 0.8, in: .meters)
        .windowResizability(.contentSize)
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
