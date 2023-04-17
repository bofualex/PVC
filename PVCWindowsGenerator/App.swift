//
//  PVCWindowsGeneratorApp.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 10.04.2023.
//

import SwiftUI
import Firebase
import Stinsen

@main
struct PVCWindowsGeneratorApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let dependencyContainer: DependencyContainer
    @State private var isLoadingMainData = true
        
    init() {
        FirebaseApp.configure()
        dependencyContainer = .defaultContainer
    }
    
    var body: some Scene {
        WindowGroup {
            switch isLoadingMainData {
            case true:
                LaunchScreenView()
                    .task {
                        performInitialization()
                    }
            case false:
                switch dependencyContainer.authService.currentUser {
                case .none:
                    authFlow
                default:
                    mainFlow
                }
            }
        }
    }
    
    private var authFlow: some View {
        NavigationViewCoordinator(AuthCoordinator(dependencyContainer: dependencyContainer)).view()
    }
    
    private var mainFlow: some View {
        Color.red
    }
    
    //MARK: - private
    private func performInitialization() {
        Task(priority: .userInitiated) {
            await dependencyContainer.authService.checkAuthStatus()
            isLoadingMainData = false
        }
    }
}
