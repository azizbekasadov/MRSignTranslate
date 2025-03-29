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
//        if SettingsConfigurationManager.shared.hasShownWelcomeMessage {
            MainSplitView()
//        } else {
//            SplashScreen()
//                .frame(width: 1000, height: 750)
//        }
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
        
        /// Used for Captions Scenario
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
        .defaultSize(width: 1.5, height: 1.1, depth: 0.8, in: .meters)
        .windowResizability(.contentSize)
        
        .windowStyle(.volumetric)
        .defaultSize(width: 0.8, height: 0.8, depth: 0.8, in: .meters)
        .windowResizability(.contentSize)
        
        ImmersiveSpace(id: WindowGroupIdentifiers.bubble) {
            SpeechBubbleView()
        }
        .immersiveContentBrightness(.automatic)
        .windowStyle(.volumetric)
        
        ImmersiveSpace(id: WindowGroupIdentifiers.avatar) {
//            AvatarView()
        }
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
