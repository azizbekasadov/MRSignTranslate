//
//  SplashScreen.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//


import SwiftUI
import SwiftData

struct SplashScreen: View {
    @StateObject private var viewModel: SplashViewModel = .init()

    var body: some View {
        VStack {
            VStack {
                Text("Welcome to the MR SignMT")
            }
            ProgressView()
        }
        .onAppear {
            viewModel.dispatch(.checkLoginState)
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
