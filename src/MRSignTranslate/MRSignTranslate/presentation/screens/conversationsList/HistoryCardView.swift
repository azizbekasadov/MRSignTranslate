//
//  HistoryCardView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 27.03.2025.
//

import Foundation
import SwiftUI

struct HistoryCardView: View {
    let item: HistoryItem
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                    .foregroundStyle(.white)
                
                if let desc = item.description {
                    Text(desc)
                        .lineLimit(1)
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.75))
                }
            }
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Text(item.timestamp.formatted(.dateTime))
                        .font(.headline)
                        .foregroundStyle(.white)
                }
                
                HStack {
                    Spacer()
                    
                    Image(systemName: "chevron.right.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                
            }
        }
        .padding(3)
    }
}


#Preview(body: {
    HistoryCardView(item: .dummy)
        .glassBackgroundEffect(displayMode: .always)
})
