//
//  MainContainer.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import SwiftUI
import Observation
import MRSignMTArchitecture

struct MainSplitView: View {
    @Inject private var router: MainRouter
    @State private var selectedSection: SidebarSection? = .scenarios
    
    @Binding private var isShowMainView: Bool
    @Binding private var isCaptionsVisible: Bool
    @Binding private var isSkeletonVisible: Bool
    @Binding private var isSkeletonOnlyVisible: Bool
    @Binding private var isBubbleVisible: Bool
    
    private let sections: [SidebarSection] = [
        .scenarios,
        .history,
        .settings
    ].sorted(
        by: { $0.order < $1.order }
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
    
    var body: some View {
        NavigationSplitView {
            SideView()
        } detail: {
            DetailView()
        }
        .navigationSplitViewStyle(.prominentDetail)
    }
    
    @ViewBuilder
    private func DetailView() -> some View {
        if let selectedSection {
            MRSignTranslate.DetailView(
                selectedSection: selectedSection,
                isShowMainView: $isShowMainView,
                isCaptionsVisible: $isCaptionsVisible,
                isSkeletonVisible: $isSkeletonVisible,
                isSkeletonOnlyVisible: $isSkeletonOnlyVisible,
                isBubbleVisible: $isBubbleVisible
            )
            .id(selectedSection.id)
        } else {
            Text("No option has ben selected")
        }
    }
    
    @ViewBuilder
    private func SideView() -> some View {
        VStack {
            List(
                sections,
                id: \.self,
                selection: $selectedSection
            ) { section in
                SectionView(section)
            }
            .listStyle(.sidebar)
            .navigationTitle("Menu")
            
            Spacer()
            
            UserFooterView()
                .padding(.horizontal, 10)
                .padding(.bottom, 24)
        }
    }
    
    @ViewBuilder
    private func SectionView(_ section: SidebarSection) -> some View {
            HStack {
                Image(systemName: section.icon)
                    .font(.system(size: 18, weight: .medium))
                
                Text(section.rawValue)
                    .font(.system(size: 18, weight: .medium)
                )
                
                Spacer()
            }
            .padding(10)
    }
    
}
