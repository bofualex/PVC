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
    
    func checkAuthStatus() async
    func checkEmailIsRegistered(_ email: String) async throws -> Bool
    func createUser(with email: String, password: String) async throws -> User
    func signIn(with email: String, password: String) async throws -> User
}

class AuthenticationService: AuthenticationServiceProtocol {
    
    var currentUser: User?
    var currentUserSubject = PassthroughSubject<User?, Never>()
    
    //MARK: - init
    init() {}
    
    //MARK: - public
    func checkEmailIsRegistered(_ email: String) async throws -> Bool {
        try await !Auth.auth().fetchSignInMethods(forEmail: email).isEmpty
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
    
    func checkAuthStatus() async {
        await withCheckedContinuation { continuation in
            Auth.auth().addStateDidChangeListener { [weak self] (auth, _) in
                if let firebaseUser = auth.currentUser {
                    self?.currentUser = try? User(from: firebaseUser)
                }
                
                continuation.resume()
            }
        }
    }
    
    //MARK: - private
    
}

class AuthenticationServiceMock: AuthenticationServiceProtocol {
    
    var currentUser: User?
    
    func checkAuthStatus() async {
        try? await Task.sleep(for: .seconds(5))
    }

    func checkEmailIsRegistered(_ email: String) async throws -> Bool {
        try await Task.sleep(for: .seconds(5))
    
        return false
    }
    
    func createUser(with email: String, password: String) async throws -> User {
        try await Task.sleep(for: .seconds(5))

        self.currentUser = .mocked
        
        return .mocked
    }
    
    func signIn(with email: String, password: String) async throws -> User {
        try await Task.sleep(for: .seconds(5))

        self.currentUser = .mocked

        return .mocked
    }
}
