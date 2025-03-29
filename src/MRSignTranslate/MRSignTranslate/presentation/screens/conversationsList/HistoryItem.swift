//
//  HistoryItem.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 27.03.2025.
//

import Foundation

struct HistoryItem: Identifiable, Hashable {
    let id: String
    let timestamp: Date
    let title: String
    let description: String?
    // TODO: add specs for the conversation
    // let scenario: Scenario
    // let conversation records: HashTable<StringKey, [String]>
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension HistoryItem {
    static let dummy: HistoryItem = .init(
        id: UUID().uuidString,
        timestamp: Date(),
        title: "Hey Caroline, I will be hosting this experiment for checking accessibility effects on the visionOS",
        description: "Some description of the experiment is also here..."
    )
    
    static let mocks: [HistoryItem] = [
        HistoryItem(
            id: UUID().uuidString,
            timestamp: Date(),
            title: "User Logged In",
            description: "User logged in from an iOS device."
        ),
        HistoryItem(
            id: UUID().uuidString,
            timestamp: Date().addingTimeInterval(-60),
            title: "Screen Viewed",
            description: "Main dashboard screen was accessed."
        ),
        HistoryItem(
            id: UUID().uuidString,
            timestamp: Date().addingTimeInterval(-120),
            title: "Profile Updated",
            description: "User updated their profile information."
        ),
        HistoryItem(
            id: UUID().uuidString,
            timestamp: Date().addingTimeInterval(-180),
            title: "Notification Received",
            description: "A new notification was received."
        ),
        HistoryItem(
            id: UUID().uuidString,
            timestamp: Date().addingTimeInterval(-240),
            title: "Item Purchased",
            description: "User purchased a premium item."
        ),
        HistoryItem(
            id: UUID().uuidString,
            timestamp: Date().addingTimeInterval(-300),
            title: "Message Sent",
            description: "User sent a message to a friend."
        ),
        HistoryItem(
            id: UUID().uuidString,
            timestamp: Date().addingTimeInterval(-360),
            title: "New Comment",
            description: "A comment was added on the post."
        ),
        HistoryItem(
            id: UUID().uuidString,
            timestamp: Date().addingTimeInterval(-420),
            title: "Settings Changed",
            description: "User modified the app settings."
        ),
        HistoryItem(
            id: UUID().uuidString,
            timestamp: Date().addingTimeInterval(-480),
            title: "Feature Toggled",
            description: "User toggled a beta feature on."
        ),
        HistoryItem(
            id: UUID().uuidString,
            timestamp: Date().addingTimeInterval(-540),
            title: "Session Ended",
            description: "User logged out and ended the session."
        )
    ]
}
