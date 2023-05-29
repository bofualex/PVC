//
//  AuthorizationViewModel.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 24.05.2023.
//

import SwiftUI
import Combine

class AuthorizationViewModel: ObservableObject {
    
    @Published var email = "jjj@ll.co"
    @Published var password = ""
    @Published var reenteredPassword = ""
    
    @Published var isLoading = false
    @Published var state = State.emailCheck
    
    @Published var apiError: Error?
    @Published var emailError: LocalError?
    @Published var passwordError: LocalError?
    @Published var reEnteredPasswordError: LocalError?

    let authService: AuthenticationServiceProtocol
    var router: AuthCoordinator.Router?
    
    private var loadTask: Task<Void, Never>?
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - init
    init(
        authService: AuthenticationServiceProtocol
    ) {
        self.authService = authService
        
        Publishers.Merge3($email, $password, $reenteredPassword)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.emailError = nil
                self?.passwordError = nil
                self?.reEnteredPasswordError = nil
            }
            .store(in: &cancellables)
    }
    
    deinit {
        loadTask?.cancel()
    }
    
    //MARK: - public
    func handleCTATapped() {
        dismissKeyboard()

        switch state {
        case .emailCheck:
            checkEmail()
        case .login:
            loginUser()
        case .signup:
            signupUser()
        }
    }
    
    func handleBackTapped() {
        state = .emailCheck
    }
    
    func handleDrag(with value: DragGesture.Value) {
        let horizontalAmount = value.translation.width
        let verticalAmount = value.translation.height
        
        if abs(horizontalAmount) <= abs(verticalAmount) {
            dismissKeyboard()
        }
    }
    
    //MARK: - private
    private func checkEmail() {
        guard email.isValidEmail else {
            emailError = LocalError(message: .errorInvalidEmail)
            return
        }
        
        isLoading = true
        
        loadTask = Task { @MainActor in
            do {
                let isRegistered = try await authService.checkEmailIsRegistered(email)
                state = isRegistered ? .login : .signup
            } catch {
                self.apiError = error
            }
            
            isLoading = false
        }
    }
    
    private func signupUser() {
        guard password.isValidPassword else {
            passwordError = LocalError(message: .errorInvalidPassword)
            return
        }
        
        guard password == reenteredPassword else {
            reEnteredPasswordError = LocalError(message: .errorPasswordsDontMatch)
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
                self.apiError = error
            }
            
            isLoading = false
        }
    }
    
    func loginUser() {        
        guard password.isValidPassword else {
            passwordError = LocalError(message: .errorInvalidPassword)
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
                self.apiError = error
            }
            
            isLoading = false
        }
    }
}

extension AuthorizationViewModel {
    enum State {
        case emailCheck, login, signup
        
        var properties: ScreenProperties {
            switch self {
            case .emailCheck:
                return .init(
                    title: .authorizationEmailCheckTitle,
                    subtitle: .authorizationEmailCheckSubtitle,
                    ctaText: .generalContinu
                )
            case .login:
                return .init(
                    title: .authorizationLoginTitle,
                    subtitle: .authorizationLoginSubtitle,
                    ctaText: .generalLogin
                )
            case .signup:
                return .init(
                    title: .authorizationSignupTitle,
                    subtitle: .authorizationSignupSubtitle,
                    ctaText: .generalSignup
                )
            }
        }
    }
    
    struct ScreenProperties {
        let title: String
        let subtitle: String
        let ctaText: String
    }
}
