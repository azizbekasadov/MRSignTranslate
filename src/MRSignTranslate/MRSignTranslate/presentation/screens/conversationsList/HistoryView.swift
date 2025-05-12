//
//  HistoryView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import SwiftUI
import MRSignMTArchitecture
import Observation

struct HistoryView: View {
    @Bindable var viewModel = HistoryViewModel(
        historyItemsRepository: MockHistoryItemRepository()
    )
    
    var body: some View {
        NavigationStack {
            ListView()
                .navigationTitle("History records")
                .accessibilityLabel("List View of the History records")
        }
        .task {
            await viewModel.fetchHistoryItems()
        }
    }
    
    @ViewBuilder
    private func ListView() -> some View {
        List(
            viewModel.historyItems,
            selection: $viewModel.selectedHistoryItem
        ) { item in
            HistoryCardView(item: item)
        }
        .cornerRadius(8, corners: .allCorners)
        .padding(.bottom, 32)
    }
}

#Preview("HistoryView Preview", body: {
    HistoryView()
})
