//
//  CoreAlertManager.swift
//  NYTimes
//
//  Created by Taimur on 20/11/2024.
//

import SwiftUI

@Observable
class CoreAlertManager: ObservableObject {
    var isPresented: Bool = false
    var model: CoreAlertModel = CoreAlertModel.defaultAlert()
    
    func showAlert(model: CoreAlertModel) {
        self.model = model
        self.isPresented = true
    }

    func dismissAlert() {
        self.isPresented = false
    }
}
