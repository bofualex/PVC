//
//  DependencyContainer.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 11.04.2023.
//

import Foundation

protocol DependencyContainerProtocol {
    var authService: any AuthenticationServiceProtocol { get }
    var networkService: any NetworkServiceProtocol { get }
    var storageService: any StorageServiceProtocol { get }
}

class DependencyContainer: DependencyContainerProtocol {
    
    let authService: AuthenticationServiceProtocol
    let networkService: NetworkServiceProtocol
    let storageService: StorageServiceProtocol
    
    init(
        authService: AuthenticationService,
        networkService: NetworkService,
        storageService: StorageService
    ) {
        self.authService = authService
        self.networkService = networkService
        self.storageService = storageService
    }
}

extension DependencyContainer {
    static let `default` = DependencyContainer(
        authService: .init(),
        networkService: .init(),
        storageService: .init()
    )
}

class DependencyContainerMock: DependencyContainerProtocol {
    
    let authService: AuthenticationServiceProtocol
    let networkService: NetworkServiceProtocol
    let storageService: StorageServiceProtocol
    
    init(
        authService: AuthenticationServiceMock,
        networkService: NetworkServiceMock,
        storageService: StorageServiceMock
    ) {
        self.authService = authService
        self.networkService = networkService
        self.storageService = storageService
    }
    
    static let `default` = DependencyContainerMock(
        authService: .init(),
        networkService: .init(),
        storageService: .init()
    )
}
