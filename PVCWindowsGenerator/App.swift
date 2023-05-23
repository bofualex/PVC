//
//  PVCWindowsGeneratorApp.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 10.04.2023.
//

import SwiftUI
import Stinsen

@main
struct PVCWindowsGeneratorApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var viewModel = AppViewModel()

    var body: some Scene {
        WindowGroup {
            switch viewModel.isAuthenticated {
            case .none:
                LaunchScreenView()
            case .some(let isAuthenticated):
                switch isAuthenticated {
                case false:
                    authFlow
                default:
                    mainFlow
                }
            }
        }
    }
    
    private var authFlow: some View {
        NavigationViewCoordinator(
            AuthCoordinator(dependencyContainer: viewModel.dependencyContainer)
        )
        .view()
    }
    
    private var mainFlow: some View {
        NavigationViewCoordinator(
            MainCoordinator(dependencyContainer: viewModel.dependencyContainer)
        )
        .view()
    }
}
