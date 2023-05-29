//
//  AppViewModel.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 18.05.2023.
//

import SwiftUI
import Combine
import Firebase

class AppViewModel: ObservableObject {
    
    @Published var isAuthenticated: Bool? = nil
    
    let dependencyContainer: DependencyContainer

    private var cancellables = Set<AnyCancellable>()

    //MARK: - init
    init() {
        FirebaseApp.configure()
        
        dependencyContainer = .default
        dependencyContainer.authService.currentUserSubject
            .receive(on: DispatchQueue.main)
            .sink { user in
                self.isAuthenticated = user != nil
            }
            .store(in: &cancellables)
        
        performInitialization()
    }
    
    //MARK: - private
    private func performInitialization() {
        Task(priority: .userInitiated) { @MainActor in
            try? await Task.sleep(for: .seconds(5))

            dependencyContainer.authService.retrieveAuthStatus()
        }
    }
}
