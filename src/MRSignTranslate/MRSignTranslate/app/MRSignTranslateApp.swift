//
//  MRSignTranslateApp.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import SwiftUI
import SwiftData
//import RealityKit
import MRSignMTArchitecture

@main
struct MRSignTranslateApp: App {
    enum WindowGroupIdentifiers {
        static let main: String = "MRSignTranslate.MainWindowGroup.main"
        static let bubble: String = "MRSignTranslate.MainWindowGroup.bubble"
        static let captions: String = "MRSignTranslate.MainWindowGroup.captions"
        static let skeleton: String = "MRSignTranslate.MainWindowGroup.skeleton"
        static let avatar: String = "MRSignTranslate.MainWindowGroup.avatar"
    }
    
    @StateObject private var router = MainRouter()
    @Bindable private var settingsConfigurator = SettingsConfigurationManager()
    
    private let dataStorageManager = DataStorageManager(
        container: .store()
    )
    
    init() {
        setupInjectionContainer()
    }
    
    var body: some Scene {
        WindowGroup {
//            NavigationStack(path: $router.path) {
//                if settingsConfigurator.hasShownWelcomeMessage {
//                    MainSplitView()
//                        .navigationDestination(
//                            for: MainDestination.self,
//                            destination: DestinationFactory.viewForDemoDestination
//                        )
//                } else {
//                    SplashScreen()
//                        .navigationDestination(
//                            for: MainDestination.self,
//                            destination: DestinationFactory.viewForDemoDestination
//                        )
//                }
//            }
//            .preferredColorScheme(.dark)
//            .modelContainer(dataStorageManager.selectedContainer)
//            .onChange(of: router.path) { oldValue, newValue in
//                print("oldPath", oldValue)
//                print("currentPath", newValue)
//            }
            CaptionsView()
        }
        .defaultSize(width: 1, height: 0.65, depth: 1.5, in: .meters)
        
        /// Used for Bubble Scenario
        WindowGroup(id: WindowGroupIdentifiers.bubble) {
            VStack {}
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.8, height: 0.8, depth: 0.8, in: .meters)
        
        /// Used for Captions Scenario
        WindowGroup(id: WindowGroupIdentifiers.captions) {
            VStack {}
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.8, height: 0.8, depth: 0.8, in: .meters)
        
        /// Used for skeleton attached to the person scenario
        WindowGroup(id: WindowGroupIdentifiers.skeleton) {
            VStack {}
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.8, height: 0.8, depth: 0.8, in: .meters)
        
        ImmersiveSpace(id: WindowGroupIdentifiers.bubble) {
            SpeechBubbleView()
        }
        
        ImmersiveSpace(id: WindowGroupIdentifiers.avatar) {
            
        }
     }
}

private extension MRSignTranslateApp {
    func setupInjectionContainer() {
        InjectionContainer.register(type: DataStorageManager.self, as: .singleton, dataStorageManager)
        InjectionContainer.register(type: MainRouter.self, as: .singleton, router)
        InjectionContainer.register(type: SettingsRouter.self, as: .singleton, SettingsRouter())
        InjectionContainer.register(
            type: SettingsConfigurationManager.self,
            as: .singleton,
            settingsConfigurator
        )
        InjectionContainer.register(type: UserRepository.self, UserRepositoryImpl())
        InjectionContainer.register(type: RemoteRepository.self, RemoteRepositoryImpl())
        InjectionContainer.register(type: EmailServiceProtocol.self, EmailService())
    }
}
