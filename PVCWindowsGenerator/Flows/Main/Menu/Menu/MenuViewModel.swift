//
//  MenuViewModel.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 20.05.2023.
//

import SwiftUI

class MenuViewModel: ObservableObject {
    
    @Published var error: Error?
    
    let authenticationService: AuthenticationServiceProtocol
    
    private var logoutTask: Task<Void, Never>?
    
    //MARK: - init
    init(authenticationService: AuthenticationServiceProtocol) {
        self.authenticationService = authenticationService
    }
    
    deinit {
        logoutTask?.cancel()
    }
    
    //MARK: - public
    func logout() {
        logoutTask = Task { @MainActor in
            do {
                try await authenticationService.logout()
            } catch {
                self.error = error
            }
        }
    }
}
