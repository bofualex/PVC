//
//  Firestore+Extensions.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 22.06.2023.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

extension Firestore {
    
    func getCollection<T: Decodable>(
        from route: NetworkRoute,
        pagination: PaginatedRequest? = nil,
        using decoder: JSONDecoder = .init()
    ) async throws -> [T] {
        var ref: Query = collection(route.rawValue)
        
        if let pagination {
            if let orderBy = pagination.orderBy {
                ref = ref.order(by: orderBy)
            }
            
            if let start = pagination.start {
                ref = ref.start(atDocument: start)
            }
            
            ref = ref.limit(to: pagination.length)
        }
        
        let snapshot = try await ref.getDocuments()
        
        let asData = try snapshot.documents.compactMap({ try JSONSerialization.data(withJSONObject: $0, options: .fragmentsAllowed) })

        return try asData.compactMap({ try decoder.decode(T.self, from: $0) })
    }
    
    func get<T: Decodable>(
        with id: String,
        from route: NetworkRoute,
        using decoder: JSONDecoder = .init()
    ) async throws -> T {
        let ref = collection(route.rawValue).document(id)
        
        return try await ref.getDocument(as: T.self)
    }
}
