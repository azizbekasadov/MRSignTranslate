//
//  DestinationFactory.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import SwiftUI

enum DestinationFactory {
    
    @ViewBuilder
    static func viewForDemoDestination(_ destination: MainDestination) -> some View {
        switch destination {
            // TODO: Language List and RealTime
        case .languageList:
            LanguageListView(destination: .language)
                .navigationBarBackButtonHidden()
                .scaleEffect(1.2)
        case .realTime:
            EmptyView()
                .navigationBarBackButtonHidden()
        case .home:
            MainSplitView(
                isShowMainView: .constant(true),
                isCaptionsVisible: .constant(true),
                isSkeletonVisible:  .constant(true),
                isSkeletonOnlyVisible:  .constant(true),
                isBubbleVisible:  .constant(true)
            )
                .navigationBarBackButtonHidden()
                .transition(.scale(scale: 1.2).combined(with: .opacity))
        case .recordings: EmptyView().navigationBarBackButtonHidden()
        case .login: EmptyView().navigationBarBackButtonHidden()
        case .settings: SettingsScreen()//.navigationBarBackButtonHidden()
        }
    }
}
