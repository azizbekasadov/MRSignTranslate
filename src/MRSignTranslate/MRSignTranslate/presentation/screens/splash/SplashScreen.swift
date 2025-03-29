//
//  SplashScreen.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//


import SwiftUI
import SwiftData

struct SplashScreen: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: SplashViewModel = .init()

    var body: some View {
        #if os(visionOS)
        MainView()
        #else
        MainView()
        #endif
    }
    
    private func MainView() -> some View {
        VStack(spacing: 40) {
            SplashView()
                .frame(alignment: .center)
            
            Spacer()
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                Button {
                    print("Tapped")
//                    viewModel.dispatch(.checkLoginState)
                    DispatchQueue.main.async {
                        self.dismiss.callAsFunction()
                        self.openWindow.callAsFunction(id: MRSignTranslateApp.WindowGroupIdentifiers.privacy)
                    }
                } label: {}
                .buttonStyle(
                    GlassButtonStyle(
                        title: "Start",
                        size: CGSize(width: 150, height: 80)
                    )
                )
                .hoverEffect()
            }
        }
        .padding(.top, 150)
        .padding([.horizontal, .bottom], 50)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
            .frame(maxWidth: 850)
            .glassBackgroundEffect(displayMode: .always)
    }
}
