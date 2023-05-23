//
//  SignupViewModel.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 04.05.2023.
//

import SwiftUI

class SignupViewModel: ObservableObject {
    
    @Published var password = ""
    @Published var reenteredPassword = ""
    @Published var isLoading = false
    @Published var error: Error?
    
    let authService: AuthenticationServiceProtocol
    var router: AuthCoordinator.Router?
    
    private let email: String
    private var loadTask: Task<Void, Never>?
    
    //MARK: - init
    init(
        authService: AuthenticationServiceProtocol,
        email: String
    ) {
        self.authService = authService
        self.email = email
    }
    
    deinit {
        loadTask?.cancel()
    }
    
    //MARK: - public
    func handleSignupTapped() {
        dismissKeyboard()
        
        guard password.isValidPassword else {
            error = LocalError(message: .errorInvalidPassword)
            return
        }
        
        guard password == reenteredPassword else {
            error = LocalError(message: .errorPasswordsDontMatch)
            return
        }
        
        isLoading = true
        
        loadTask = Task { @MainActor in
            do {
                try await authService.createUser(
                    with: email,
                    password: password
                )
            } catch {
                self.error = error
            }
            
            isLoading = false
        }
    }
}

