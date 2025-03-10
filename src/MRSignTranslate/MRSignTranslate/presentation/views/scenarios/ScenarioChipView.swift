//
//  ScenarioChipView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import SwiftUI
import UIKit

struct ScenarioChipView: View {
    private enum Constants {
        enum Images {
            static let mockImage = "mocks/scenario/chip_bg"
        }
        
        enum Corners {
            static let radius: CGFloat = 12
            static let size: CGSize = CGSize(width: radius, height: radius)
        }
        
        enum Frame {
            static var width: CGFloat {
                #if os(visionOS)
                return 400
                #elseif canImport(UIKit)
                return UIScreen.main.bounds.width - 32
                #else
                return 300.0
                #endif
            }
            
            static var height: CGFloat {
                #if os(visionOS)
                return 500
                #elseif canImport(UIKit)
                return UIScreen.main.bounds.width * 1.1
                #else
                return 400.0
                #endif
            }
        }
    }
    
    var body: some View {
        VStack {
            Image("mocks/scenario/chip_bg")
                .resizable()
                .clipped()
                .border(
                    width: 1,
                    edges: [.top, .bottom, .leading, .trailing],
                    color: Color(hex: "#252A28")
                )
                .cornerRadius(12, corners: .allCorners)
            
            VStack(
                alignment: .leading,
                spacing: 6
            ) {
                HStack {
                    Text("Scenario 1")
                        .font(.headline)
                        .foregroundStyle(Color(UIColor.systemGray4))
                    Spacer()
                }
                
                HStack {
                    Text("Bubbles and Dolls")
                        .font(.largeTitle)
                        .lineLimit(nil)
                    Spacer()
                }
                
                HStack {
                    Text("Catch the conversation with bubble dialogues with the person")
                        .font(.subheadline)
                        .lineLimit(nil)
                        .foregroundStyle(Color(UIColor.systemGray4))
                    Spacer()
                }
                Spacer().frame(maxHeight: 10)
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


#Preview {
    ScenarioChipView()
        .background(Color(hex: "#1D1D1D"))
        .frame(
            maxWidth: 500,
            maxHeight: 400
        )
        .cornerRadius(12, corners: .allCorners)
}
