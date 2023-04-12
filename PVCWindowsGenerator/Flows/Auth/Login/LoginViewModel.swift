//
//  LoginViewModel.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 11.04.2023.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    let authService: AuthenticationServiceProtocol
    
    //MARK: - init
    init(authService: AuthenticationServiceProtocol) {
        self.authService = authService
    }
    
}
