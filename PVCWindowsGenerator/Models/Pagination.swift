//
//  Pagination.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 22.06.2023.
//

import Foundation
import FirebaseFirestore

struct PaginatedRequest {
            
    var start: DocumentSnapshot? = nil
    var length = 20
    var orderBy: String? = nil
    
    mutating func reset() {
        start = nil
        length = 20
        orderBy = nil
    }
}

struct PaginatedResponse<Item: Decodable>: Decodable {
    var total: Int
    var data: [Item]
}
