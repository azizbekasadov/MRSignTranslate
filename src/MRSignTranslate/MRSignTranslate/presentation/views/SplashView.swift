//
//  SplashView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation
import SwiftUI

struct SplashView: View {
    private enum Constants {
        enum Texts {
            static let title: String = "Welcome to the MR SignMT"
            static let description: String = "Experience real-time sign language translation in immersive Mixed Reality with SignMR on VisionOS."
        }
        
        enum Images {
            static let appIcon: String = "appicon"
        }
    }
    
    var body: some View {
        VStack {
            Image(Constants.Images.appIcon)
                .resizable()
                .frame(width: 150, height: 150)
                .cornerRadius(75, corners: .allCorners)
                .shadow(radius: 10)
            
            VStack(spacing: 20) {
                Text(Constants.Texts.title)
                    .font(.system(size: 40, weight: .bold))
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    
                Text(Constants.Texts.description)
                    .font(.system(size: 32, weight: .medium))
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.top, 30)
        }
    }
}
