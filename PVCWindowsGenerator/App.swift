//
//  PVCWindowsGeneratorApp.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 10.04.2023.
//

import SwiftUI
import Firebase

@main
struct PVCWindowsGeneratorApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State private var dependencyContainer: DependencyContainer
    @State private var isLoadingMainData = true
    
    init() {
        FirebaseApp.configure()
        
        _dependencyContainer = .init(
            initialValue: .init(
                authService: .init(),
                networkService: .init(),
                storageService: .init()
            )
        )
    }
    
    var body: some Scene {
        WindowGroup {
            switch isLoadingMainData {
            case true:
                LaunchScreenView()
                    .onReceive(dependencyContainer.authService.hasInitializedSessionSubject) { newValue in
                        isLoadingMainData = !newValue
                    }
            case false:
                switch dependencyContainer.authService.currentUser {
                case .none:
                    EmailCheckView(
                        viewModel: .init(authService: dependencyContainer.authService)
                    )
                default:
                    EmptyView()
                }
            }
        }
    }
}
