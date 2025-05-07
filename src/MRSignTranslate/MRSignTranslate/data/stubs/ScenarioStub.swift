//
//  ScenarioStub.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import Foundation

extension Scenario {
    enum Identifiers: Int, Identifiable, CaseIterable {
        case scenario1 = 0, scenario2, scenario3, scenario4
        
        var id: String {
            switch self {
            case .scenario1:
                return "scenario-1-bubble"
            case .scenario2:
                return "scenario-2-captions"
            case .scenario3:
                return "scenario-3-avatar"
            case .scenario4:
                return "scenario-4-chat"
            }
        }
    }
    
    static let scenarios: [Scenario] = [
        Scenario(
            id: "scenario-1-bubble",
            title: "Real-Time Transcription Bubble",
            thumbnail: "scenarios/1",
            backgroundImage: "scenarios/1",
            level: .easy,
            description: "A floating speech bubble near the real person displays live transcriptions of sign language into text for seamless communication.",
            instructions: ["Step 1", "Step 2"],
            scenarioWindowId: MRSignTranslateApp.WindowGroupIdentifiers.bubble,
            type: .bubble,
            localizedStringResource: "NEW GAME"
        ),
        Scenario(
            id: "scenario-2-captions",
            title: "Captions Overlay on Current Frame",
            thumbnail: "scenarios/2",
            backgroundImage: "scenarios/2",
            level: .medium,
            description: "Live captions appear near the person in the current camera frame, providing real-time subtitles for sign language interpretation.",
            instructions: ["Step 1", "Step 2"],
            scenarioWindowId: MRSignTranslateApp.WindowGroupIdentifiers.captions,
            type: .captions,
            localizedStringResource: "PRE-ORDER"
        ),
        Scenario(
            id: "scenario-3-avatar",
            title: "Skeleton Avatar Signing Spoken Language with Text Bubble",
            thumbnail: "scenarios/3",
            backgroundImage: "gardenscapes_bg",
            level: .hard,
            description: "A digital avatar mimics the real person, translating spoken language into sign language gestures for accessibility.",
            instructions: ["Step 1", "Step 2"],
            scenarioWindowId: MRSignTranslateApp.WindowGroupIdentifiers.skeleton,
            type: .skeleton,
            localizedStringResource: "LIMITED TIME"
        ),
        Scenario(
            id: "scenario-5-chat",
            title: "Skeleton only Signing Spoken Language",
            thumbnail: "scenarios/5",
            backgroundImage: "scenarios/5",
            level: .hard,
            description: "A digital skeleton avatar that will translate speech right instantly from speech",
            instructions: ["Step 1", "Step 2", "Step 3"],
            scenarioWindowId: MRSignTranslateApp.WindowGroupIdentifiers.skeletonOnly,
            type: .skeletonOnly,
            localizedStringResource: "LIMITED TIME"
        ),
        Scenario(
            id: "scenario-4-chat",
            title: "Avatar USDZ Sign Spoken Language",
            thumbnail: "scenarios/4",
            backgroundImage: "scenarios/4",
            level: .hard,
            description: "A dynamic chatroom where multiple people converse, with AI avatars translating spoken language into sign language for inclusive communication.",
            instructions: ["Step 1", "Step 2", "Step 3"],
            scenarioWindowId: MRSignTranslateApp.WindowGroupIdentifiers.avatar,
            isImmersiveWindow: true,
            type: .avatar,
            localizedStringResource: "LIMITED TIME"
        ),
    ]
}
