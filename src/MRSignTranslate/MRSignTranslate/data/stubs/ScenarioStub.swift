//
//  ScenarioStub.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import Foundation

extension Scenario {
    static let scenarios: [Scenario] = [
        Scenario(
            id: UUID(),
            title: "Real-Time Transcription Bubble",
            thumbnail: "scenarios/1",
            backgroundImage: "scenarios/1",
            level: .easy,
            description: "A floating speech bubble near the real person displays live transcriptions of sign language into text for seamless communication.",
            instructions: ["Step 1", "Step 2"],
            localizedStringResource: "NEW GAME"
        ),
        Scenario(
            id: UUID(),
            title: "Captions Overlay on Current Frame",
            thumbnail: "scenarios/2",
            backgroundImage: "scenarios/2",
            level: .medium,
            description: "Live captions appear near the person in the current camera frame, providing real-time subtitles for sign language interpretation.",
            instructions: ["Step 1", "Step 2"],
            localizedStringResource: "PRE-ORDER"
        ),
        Scenario(
            id: UUID(),
            title: "AI Avatar Signing Spoken Language",
            thumbnail: "scenarios/3",
            backgroundImage: "gardenscapes_bg",
            level: .hard,
            description: "A digital avatar mimics the real person, translating spoken language into sign language gestures for accessibility.",
            instructions: ["Step 1", "Step 2"],
            localizedStringResource: "LIMITED TIME"
        ),
        Scenario(
            id: UUID(),
            title: "Multi-Person Sign Language Chat",
            thumbnail: "scenarios/4",
            backgroundImage: "scenarios/4",
            level: .hard,
            description: "A dynamic chatroom where multiple people converse, with AI avatars translating spoken language into sign language for inclusive communication.",
            instructions: ["Step 1", "Step 2", "Step 3"],
            localizedStringResource: "LIMITED TIME"
        )
    ]
}
