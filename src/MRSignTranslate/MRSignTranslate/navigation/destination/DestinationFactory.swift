//
//  DestinationFactory.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation


import Foundation
import SwiftUI
import SwiftData

class DestinationFactory {
    @ViewBuilder
    static func viewForDemoDestination(_ destination: MainDestination) -> some View {
        switch destination {
            // TODO: Language List and RealTime
        case .languageList: EmptyView().navigationBarBackButtonHidden()
        case .realTime: EmptyView().navigationBarBackButtonHidden()
        case .home: EmptyView().navigationBarBackButtonHidden()
        case .recordings: EmptyView().navigationBarBackButtonHidden()
        case .login: EmptyView().navigationBarBackButtonHidden()
        }
    }
}
