//
//  EmailManager.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import Foundation
import SwiftUI
import UIKit

protocol EmailServiceProtocol {
    func openEmail(to recipient: String, subject: String, body: String)
}

struct EmailService: EmailServiceProtocol {
    func openEmail(
        to recipient: String = GlobalConstants.Email.recipient,
        subject: String = GlobalConstants.Email.recipient,
        body: String = "Hi!\n"
    ) {
        let formattedSubject = subject.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) ?? ""
        
        let formattedBody = body.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) ?? ""
        
        if let emailURL = URL(
            string: "mailto:\(recipient)?subject=\(formattedSubject)&body=\(formattedBody)"
        ) {
            if UIApplication.shared.canOpenURL(emailURL) {
                UIApplication.shared.open(emailURL)
            }
        }
    }
}
