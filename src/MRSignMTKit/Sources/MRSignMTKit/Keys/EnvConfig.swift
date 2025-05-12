//
//  File.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 19.03.2025.
//

import Foundation

struct FirebaseConfig {
    let apiKey: String
    let authDomain: String
    let projectId: String
    let storageBucket: String
    let messagingSenderId: String
    let appId: String
    let measurementId: String?
}

struct MREnvironment {
    let production: Bool
    let firebase: FirebaseConfig
    let reCAPTCHAKey: String
}

// Creating the environment configuration
let devEnvironment = MREnvironment(
    production: false,
    firebase: FirebaseConfig(
        apiKey: "AIzaSyAtVDGmDVCwWunWW2ocgeHWnAsUhHuXvcg",
        authDomain: "sign-mt.firebaseapp.com",
        projectId: "sign-mt",
        storageBucket: "sign-mt.appspot.com",
        messagingSenderId: "665830225099",
        appId: "1:665830225099:web:18e0669d5847a4b047974e",
        measurementId: nil
    ),
    reCAPTCHAKey: ""
)

// Creating the environment configuration
let prodEnvironment = MREnvironment(
    production: true,
    firebase: FirebaseConfig(
        apiKey: "AIzaSyAtVDGmDVCwWunWW2ocgeHWnAsUhHuXvcg",
        authDomain: "sign-mt.firebaseapp.com",
        projectId: "sign-mt",
        storageBucket: "sign-mt.appspot.com",
        messagingSenderId: "665830225099",
        appId: "1:665830225099:web:18e0669d5847a4b047974e",
        measurementId: "G-1LXY5W5Z9H"
    ),
    reCAPTCHAKey: "6Ldsxb8oAAAAAGyUZbyd0QruivPSudqAWFygR-4t"
)
