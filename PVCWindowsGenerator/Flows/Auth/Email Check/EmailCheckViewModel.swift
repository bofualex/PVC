//
//  EmailCheckViewModel.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 11.04.2023.
//

import SwiftUI

class EmailCheckViewModel: ObservableObject {
    
    let authService: AuthenticationServiceProtocol
    
    //MARK: - init
    init(authService: AuthenticationServiceProtocol) {
        self.authService = authService
    }
}
