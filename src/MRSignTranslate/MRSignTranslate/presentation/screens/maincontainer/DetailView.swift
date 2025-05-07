//
//  DetailView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import SwiftUI
import MRSignMTArchitecture

// MARK: - Detail Content Area
struct DetailView: View {
    var selectedSection: SidebarSection?

    @Binding private var isShowMainView: Bool
    @Binding private var isCaptionsVisible: Bool
    @Binding private var isSkeletonVisible: Bool
    @Binding private var isSkeletonOnlyVisible: Bool
    @Binding private var isBubbleVisible: Bool

    init(
        selectedSection: SidebarSection? = nil,
        isShowMainView: Binding<Bool>,
        isCaptionsVisible: Binding<Bool>,
        isSkeletonVisible: Binding<Bool>,
        isSkeletonOnlyVisible: Binding<Bool>,
        isBubbleVisible: Binding<Bool>
    ) {
        self.selectedSection = selectedSection
        
        self._isShowMainView = isShowMainView
        self._isCaptionsVisible = isCaptionsVisible
        self._isSkeletonVisible = isSkeletonVisible
        self._isSkeletonOnlyVisible = isSkeletonOnlyVisible
        self._isBubbleVisible = isBubbleVisible
    }
    
    var body: some View {
        Group {
            switch selectedSection {
            case .home:
                EmptyView()
            case .scenarios:
                ScenariosView(
                    isShowMainView: $isShowMainView,
                    isCaptionsVisible: $isCaptionsVisible,
                    isSkeletonVisible: $isSkeletonVisible,
                    isSkeletonOnlyVisible: $isSkeletonOnlyVisible,
                    isBubbleVisible: $isBubbleVisible
                )
            case .settings:
                SettingsScreen()
            case .history:
                HistoryScreenFactory(repositoryType: .mock).make()
            case .none:
                Text("Select a Section").font(.largeTitle)
            }
        }
        .navigationTitle(selectedSection?.rawValue ?? "VisionOS App")
    }
}
