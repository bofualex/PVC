//
//  AuthenticationService.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 11.04.2023.
//

import Foundation
import FirebaseAuth
import Combine

protocol AuthenticationServiceProtocol {
    
    var currentUser: User? {get set}
    
    func checkEmailIsRegistered(_ email: String) async throws -> Bool
    func createUser(with email: String, password: String) async throws -> User
    func signIn(with email: String, password: String) async throws -> User
}

class AuthenticationService: AuthenticationServiceProtocol {
    
    var currentUser: User?
    var currentUserSubject = PassthroughSubject<User?, Never>()
    var hasInitializedSessionSubject = PassthroughSubject<Bool, Never>()
    
    //MARK: - init
    init() {
        checkAuthStatus()
    }
    
    //MARK: - public
    func checkEmailIsRegistered(_ email: String) async throws -> Bool {
        try await Auth.auth().fetchSignInMethods(forEmail: email).isEmpty
    }
    
    func createUser(with email: String, password: String) async throws -> User {
        let response = try await Auth.auth().createUser(withEmail: email, password: password)
        let user = try User(from: response.user)
        self.currentUser = user
        
        return user
    }
    
    func signIn(with email: String, password: String) async throws -> User {
        let response = try await Auth.auth().signIn(withEmail: email, password: password)
        let user = try User(from: response.user)
        self.currentUser = user
        
        return user
    }
    
    //MARK: - private
    private func checkAuthStatus() {
        Auth.auth().addStateDidChangeListener { [weak self] (auth, _) in
            guard let firebaseUser = auth.currentUser else {
                self?.currentUserSubject.send(nil)
                self?.hasInitializedSessionSubject.send(true)
                return
            }
            
            self?.currentUser = try? User(from: firebaseUser)
            self?.currentUserSubject.send(self?.currentUser)
            self?.hasInitializedSessionSubject.send(true)
        }
    }
}

class AuthenticationServiceMock: AuthenticationServiceProtocol {
    
    var currentUser: User?

    func checkEmailIsRegistered(_ email: String) async throws -> Bool {
        return false
    }
    
    func createUser(with email: String, password: String) async throws -> User {
        self.currentUser = .mocked
        
        return .mocked
    }
    
    func signIn(with email: String, password: String) async throws -> User {
        self.currentUser = .mocked

        return .mocked
    }
}
