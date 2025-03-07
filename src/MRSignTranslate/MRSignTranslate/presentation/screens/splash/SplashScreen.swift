//
//  SplashScreen.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//


import SwiftUI
import SwiftData

struct SplashScreen: View {
    private enum Constants {
        enum Texts {
            static let title: String = "Welcome to the MR SignMT"
            static let description: String = "Step into a new era of communication with SignMR on VisionOS, where real-time sign language translation meets immersive Mixed Reality for effortless interaction"
        }
        
        enum Images {
            static let appIcon: String = "appicon"
        }
    }
    
    @StateObject private var viewModel: SplashViewModel = .init()

    var body: some View {
        VStack(spacing: 40) {
            VStack {
                Image(Constants.Images.appIcon)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .cornerRadius(75, corners: .allCorners)
                    .shadow(radius: 10)
                
                VStack(spacing: 20) {
                    Text(Constants.Texts.title)
                        .font(.extraLargeTitle)
                        .lineLimit(nil)
                        .multilineTextAlignment(.center)
                        
                    Text(Constants.Texts.description)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.top, 30)
            }
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                Button {
                    viewModel.dispatch(.checkLoginState)
                } label: {}
                .buttonStyle(
                    GlassButtonStyle(
                        title: "Start",
                        size: CGSize(width: 150, height: 80)
                    )
                )
            }

        }
        .padding(50)
        .frame(maxWidth: 850)
        .glassBackgroundEffect(displayMode: .always)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
