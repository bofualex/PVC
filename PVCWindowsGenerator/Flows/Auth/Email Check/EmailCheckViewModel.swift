//
//  EmailCheckViewModel.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 11.04.2023.
//

import SwiftUI

class EmailCheckViewModel: ObservableObject {
    
    @Binding var email: String
    @Published var isLoading = false
    @Published var error: Error?
    
    let authService: AuthenticationServiceProtocol
    var router: AuthCoordinator.Router?
    
    private var loadTask: Task<Void, Never>?
    
    //MARK: - init
    init(
        authService: AuthenticationServiceProtocol,
        email: Binding<String>
    ) {
        self.authService = authService
        self._email = email
    }
    
    deinit {
        loadTask?.cancel()
    }
    
    //MARK: - public
    func checkEmail() {
        guard email.isValidEmail else {
            error = LocalError(message: .errorInvalidEmail)
            return
        }
        
        isLoading = true
        
        loadTask = Task { @MainActor in
            do {
                let isRegistered = try await authService.checkEmailIsRegistered(email)
                handleIsRegisteredResponse(isRegistered)
            } catch {
                self.error = error
            }
            
            isLoading = false
        }
    }
    
    //MARK: - private
    private func handleIsRegisteredResponse(_ isRegistered: Bool) {
        switch isRegistered {
        case false:
            router?.route(to: \.signupView)
        case true:
            router?.route(to: \.loginView)
        }
    }
}
