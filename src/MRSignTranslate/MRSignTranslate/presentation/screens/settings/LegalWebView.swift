//
//  LegalWebView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import SwiftUI
import WebKit

struct LegalWebView: View {
    let destination: SettingsCategories.General
    
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        #if os(visionOS)
        MainView()
            .background(.thickMaterial)
            .cornerRadius(16, corners: .allCorners)
            .navigationTitle(title)
        #else
        MainView()
            .background(Color(hex: "#1D1D1D").opacity(0.5))
            .cornerRadius(16, corners: .allCorners)
            .navigationTitle(title)
        #endif
    }
    
    @ViewBuilder
    private func MainView() -> some View {
        VStack {
            Text(title)
                .font(.title)
                .padding()
            
            if let url {
                WebView(url: url)
            } else {
                Text("Unable to open the link")
                    .font(.title)
                    .foregroundStyle(.red)
            }
            
            OpenInSafari()
                .padding(16)
        }
    }
    
    @ViewBuilder
    private func OpenInSafari() -> some View {
        Button("Open in Safari") {
            if let url = url {
                openURL(url)
            }
        }
        .buttonStyle(.plain)
        .font(.headline)
        .foregroundColor(.blue)
        .padding()
        .background(.white.opacity(0.1))
        .cornerRadius(50, corners: .allCorners)
    }
    
    private var url: URL? {
        switch destination {
        case .terms:
            return GlobalConstants.URLs.terms
        case .privacy:
            return GlobalConstants.URLs.privacy
        default: return nil
        }
    }
    
    private var title: String {
        switch destination {
        case .terms:
            return "Terms & Conditions"
        case .privacy:
            return "Privacy Policy"
        default: return "Invalid Destination"
        }
    }
}

#Preview {
    LegalWebView(
        destination: .terms
    )
}
