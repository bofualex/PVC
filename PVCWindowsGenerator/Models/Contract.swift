//
//  Contract.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 22.06.2023.
//

import Foundation

struct Contract: Identifiable, Equatable, Hashable, Decodable {
    
    let id: String
    let title: String
    let status: Status
}

extension Contract {
    enum Status: String, Decodable, CaseIterable {
        case new, pending, inProgress, completed
    }
}

extension Contract {
    static var mocked: [Contract] = {
        (1 ... 10).compactMap({
            Contract(
                id: $0.description,
                title: $0.description,
                status: Status.allCases.randomElement()!)
        })
    }()
}
