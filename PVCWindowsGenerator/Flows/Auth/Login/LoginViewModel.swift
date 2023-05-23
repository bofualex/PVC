//
//  LoginViewModel.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 11.04.2023.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var password = ""
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
    func handleLoginTapped() {
        dismissKeyboard()
        
        guard password.isValidPassword else {
            error = LocalError(message: .errorInvalidPassword)
            return
        }

        isLoading = true
        
        loadTask = Task { @MainActor in
            do {
                try await authService.signIn(
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
