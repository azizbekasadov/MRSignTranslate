//
//  MRSignTranslateApp.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import SwiftUI
import SwiftData
import MRSignMTArchitecture

@main
struct MRSignTranslateApp: App {
    @Bindable var router = MainRouter()
    
    let dataStorageManager = DataStorageManager(
        container: .store()
    )
    
    init() {
        setupInjectionContainer()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                MainSplitView()
                    .navigationDestination(for: MainDestination.self, destination: DestinationFactory.viewForDemoDestination)
            }
            .preferredColorScheme(.dark)
            .modelContainer(dataStorageManager.selectedContainer)
            .onChange(of: router.path) { oldValue, newValue in
                print("oldPath", oldValue)
                print("currentPath", newValue)
            }
        }
     }
}

private extension MRSignTranslateApp {
    func setupInjectionContainer() {
        InjectionContainer.register(type: DataStorageManager.self, as: .singleton, dataStorageManager)
        InjectionContainer.register(type: MainRouter.self, as: .singleton, router)
        InjectionContainer.register(type: UserRepository.self, UserRepositoryImpl())
        InjectionContainer.register(type: RemoteRepository.self, RemoteRepositoryImpl())
    }
}
