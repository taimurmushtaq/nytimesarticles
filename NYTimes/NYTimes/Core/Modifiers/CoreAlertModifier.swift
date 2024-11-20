//
//  CoreAlertModifier.swift
//  NYTimes
//
//  Created by Taimur on 20/11/2024.
//

import SwiftUI

struct CoreAlertModel {
    let title: String
    let message: String
    let primaryButton: Alert.Button
    var secondaryButton: Alert.Button? = nil
    
    static func defaultAlert() -> CoreAlertModel {
        return CoreAlertModel(title: "Alert!", message: "Something went wrong, please try again later", primaryButton: .cancel(), secondaryButton: nil)
    }
}

struct CoreAlertModifier: ViewModifier {
    @ObservedObject var alertManager: CoreAlertManager
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: $alertManager.isPresented) {
                if let secondaryButton = alertManager.model.secondaryButton {
                    return Alert(
                        title: Text(alertManager.model.title),
                        message: Text(alertManager.model.message),
                        primaryButton: alertManager.model.primaryButton,
                        secondaryButton: secondaryButton
                    )
                } else {
                    return Alert(
                        title: Text(alertManager.model.title),
                        message: Text(alertManager.model.message),
                        dismissButton: alertManager.model.primaryButton
                    )
                }
            }
    }
}

extension View {
    func showAlert(with manager: CoreAlertManager) -> some View {
        self.modifier(CoreAlertModifier(alertManager: manager))
    }
}
