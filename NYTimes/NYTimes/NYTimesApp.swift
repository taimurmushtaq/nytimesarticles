//
//  NYTimesApp.swift
//  NYTimes
//
//  Created by Taimur on 20/11/2024.
//

import SwiftUI

@main
struct NYTimesApp: App {
    @StateObject var coordinator = CoreCoordinator(rootPage: .articlesList)
    
    var body: some Scene {
        WindowGroup {
            appNavigation()
        }
    }
}

extension NYTimesApp {
    @ViewBuilder func appNavigation() -> some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.getView(page: coordinator.rootPage)
                .navigationDestination(for: CorePage.self) { page in
                    coordinator.getView(page: page)
                }
        }
        .environmentObject(coordinator)
    }
}
