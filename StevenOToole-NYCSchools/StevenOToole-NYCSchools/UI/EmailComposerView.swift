//
//  EmailComposerView.swift
//  StevenOToole-NYCSchools
//
//  Created by Steven O'Toole on 9/14/23.
//

import SwiftUI
import MessageUI
import OSLog

struct EmailComposerView: UIViewControllerRepresentable {
    let recipient: String
    private let emailTitle = "Admission Request"

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mail = MFMailComposeViewController()
        mail.setSubject(emailTitle)
        mail.setToRecipients([recipient])
        mail.mailComposeDelegate = context.coordinator
        return mail
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    func makeCoordinator() -> Coordinator { Coordinator() }
    
    static var canSend: Bool { MFMailComposeViewController.canSendMail() }
}

extension EmailComposerView {
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            if let error {
                Logger.email.error("Error: \(error, privacy: .public); result: \(result.rawValue)")
                // I think this is an edge case, for now it's not worth reporting the error
            }
            controller.dismiss(animated: true, completion: nil)
        }
    }
}
