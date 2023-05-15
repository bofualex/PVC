//
//  LocalError.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 03.05.2023.
//

import Foundation

struct LocalError: LocalizedError {
        
    let message: String
    
    var errorDescription: String? {
        message
    }
}
