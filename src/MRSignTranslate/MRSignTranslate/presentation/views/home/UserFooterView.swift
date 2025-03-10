//
//  File.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 10.03.2025.
//

import Foundation
import SwiftUI
import MRSignMTArchitecture

struct UserFooterView: View {

    @Inject private var router: MainRouter
    @StateObject private var viewModel: UserFooterViewModel = .init()
    
    var body: some View {
        HStack {
            AvatarImageView()
            MainView()
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
            viewModel.dispatch(.initialLoad)
        }
    }
    
    @ViewBuilder
    private func MainView() -> some View {
        VStack {
            MenuView()
            
            OSSandVersionView()
        }
    }
    
    @ViewBuilder
    private func AvatarImageView() -> some View {
        if let imageData = viewModel.state.avatar,
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .background(Color.gray)
                .clipShape(Circle())
        } else {
            Image(systemName: "person")
                .frame(width: 50, height: 50)
                .background(Color.gray)
                .clipShape(Circle())
        }
    }
    
    @ViewBuilder
    private func MenuView() -> some View {
        Menu {
            Button {
                logout()
            } label: {
                Text("Logout")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Color.gray)
            }
            .buttonStyle(.plain)
        } label: {
            HStack {
                Text("\(viewModel.state.userName ?? "")")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                Image(systemName: "chevron.down")
                    .renderingMode(.template)
                    .imageScale(.small)
                    .foregroundStyle(.primary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func OSSandVersionView() -> some View {
        let deviceOsVersion = UIDevice.current.systemVersion
        
        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "-"
        let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "-"
        
        Text("OS Version: \(deviceOsVersion) / \(appVersion) \(buildNumber)")
            .font(.system(size: 15, weight: .light))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func logout() {
        viewModel.dispatch(.logout {
            router.popToRoot()
        })
    }
}

#Preview {
    UserFooterView()
}
