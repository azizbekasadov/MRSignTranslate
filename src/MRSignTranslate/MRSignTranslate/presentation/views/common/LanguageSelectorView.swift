//
//  LanguageSelectorView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 17.04.2025.
//

import Foundation
import SwiftUI
import Observation
import MRSignMTKit

@Observable
final class LanguageSelectorViewModel {
    var currentSelectedLanguage: MRLanguage = .usLocale
    
    func onLanguageSelectorPressed() {
        
    }
}

struct LanguageSelectorView: View {
    @Bindable private var viewModel: LanguageSelectorViewModel
    
    init(viewModel: LanguageSelectorViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Button {
            viewModel.onLanguageSelectorPressed()
        } label: {
            ZStack {
                HStack {
                    IconImageView(
                        viewModel
                            .currentSelectedLanguage
                            .iconName
                            .asFlagName
                    )
                    
                    TextTitleView()
                    
                    VStack {
                        Spacer()
                        ChevronImageView()
                        Spacer()
                    }
                    .frame(maxWidth: 42, maxHeight: 42)
                    .padding(.trailing, 6)
                }
                .background(
                    Capsule(style: .circular)
                        .background(.white)
                )
                .clipShape(
                    Capsule(style: .circular)
                )
            }
        }
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    private func TextTitleView() -> some View {
        Text(viewModel.currentSelectedLanguage.title)
            .font(.title)
            .fontWeight(.semibold)
            .foregroundStyle(.black)
            .padding(.trailing, 12)
            .padding(.vertical, 10)
    }
    
    @ViewBuilder
    private func IconImageView(
        _ imageName: String
    ) -> some View {
        VStack {
            imageName.image
                .resizable()
                .frame(width: 50, height: 50)
                .frame(depth: 1.1)
                .shadow(radius: 3)
                .padding(.all, 5)
        }
        .background(
            Circle()
                .background(.white.opacity(0.98))
                .shadow(radius: 3)
        )
        .clipShape(Circle())
    }
}

extension LanguageSelectorView {
    private enum Configuration {
        enum Images {
            static let mockImage = Image("icons/flags/🇨🇭")
            static let chevronDown = Image(systemName: "chevron.down")
        }
    }
}

#Preview("LanguageSelectorView") {
    LanguageSelectorView(viewModel: .init())
}
