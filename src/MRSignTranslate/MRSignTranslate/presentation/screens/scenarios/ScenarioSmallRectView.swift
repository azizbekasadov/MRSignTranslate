//
//  ScenarioSmallRectView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 10.03.2025.
//

import SwiftUI
import MRSignMTArchitecture


struct ScenarioSmallRectView: View {
    private let item: ScenarioSmallRectItem
    private let action: (() -> Void)?
    
    init(
        item: ScenarioSmallRectItem,
        action: (() -> Void)? = nil
    ) {
        self.item = item
        self.action = action
    }
    
    var body: some View {
        Group {
            HStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .foregroundColor(Color.gray)
                    .frame(width: 50, height: 50)
                    .overlay {
                        Image(item.buttonIconName)
                            .resizable()
                            .cornerRadius(12, corners: .allCorners)
                            .clipped()
                    }
                
                VStack(alignment: .leading) {
                    Text(item.title)
                        .bold()
                    
                    Text(item.description)
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                }
                Spacer()
                
                VStack {
                    Spacer()
                    GetButton(
                        title: item.buttonTitle,
                        action: action
                    )
                    .frame(width: 120, height: 32)
                    .padding(.bottom, -3)
                   
                    InAppPurchasesLabel(text: item.purchaseTitle)
                    
                    Spacer()
                }
            }
        }
        .hoverEffect(.highlight)
    }
}

#Preview {
    NavigationView {
        ScenarioSmallRectView(
            item: .init(
                type: .instructions,
                title: "Instructions",
                description: "Learn how to use the app",
                buttonIconName: "options/dictionary",
                purchaseTitle: "10 mins read"
            )
        )
    }
}
