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
    var currentUserSubject: PassthroughSubject<User?, Never> {get set}

    func retrieveAuthStatus()
    func checkEmailIsRegistered(_ email: String) async throws -> Bool
    @discardableResult
    func createUser(with email: String, password: String) async throws -> User
    @discardableResult
    func signIn(with email: String, password: String) async throws -> User
    func logout() async throws
}

class AuthenticationService: AuthenticationServiceProtocol {
    
    var currentUser: User? {
        didSet {
            self.currentUserSubject.send(currentUser)
        }
    }
    var currentUserSubject = PassthroughSubject<User?, Never>()
        
    //MARK: - init
    init() {}
    
    //MARK: - public
    func checkEmailIsRegistered(_ email: String) async throws -> Bool {
        try await !Auth.auth().fetchSignInMethods(forEmail: email).isEmpty
    }
    
    @discardableResult
    func createUser(with email: String, password: String) async throws -> User {
        let response = try await Auth.auth().createUser(withEmail: email, password: password)
        let user = try User(from: response.user)
        self.currentUser = user
        
        return user
    }
    
    @discardableResult
    func signIn(with email: String, password: String) async throws -> User {
        let response = try await Auth.auth().signIn(withEmail: email, password: password)
        let user = try User(from: response.user)
        
        self.currentUser = user
        
        return user
    }
    
    func retrieveAuthStatus() {
        Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
            if let user {
                self?.currentUser = try? User(from: user)
            }
        }
    }
    
    func logout() async throws {
        try Auth.auth().signOut()
        
        self.currentUser = nil
    }
    
    //MARK: - private
    
}

class AuthenticationServiceMock: AuthenticationServiceProtocol {
    
    var currentUser: User?
    var currentUserSubject = PassthroughSubject<User?, Never>()

    func retrieveAuthStatus() {
        Task {
            try? await Task.sleep(for: .seconds(5))
            
            self.currentUser = .mocked
        }
    }

    func checkEmailIsRegistered(_ email: String) async throws -> Bool {
        try await Task.sleep(for: .seconds(5))
    
        return false
    }
    
    @discardableResult
    func createUser(with email: String, password: String) async throws -> User {
        try await Task.sleep(for: .seconds(5))

        self.currentUser = .mocked
        
        return .mocked
    }
    
    @discardableResult
    func signIn(with email: String, password: String) async throws -> User {
        try await Task.sleep(for: .seconds(5))

        self.currentUser = .mocked

        return .mocked
    }
    
    func logout() async throws {
        try await Task.sleep(for: .seconds(3))

        self.currentUser = nil
    }
}
