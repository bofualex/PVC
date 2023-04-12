//
//  User.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 11.04.2023.
//

import Foundation
import FirebaseAuth

class User: Codable, Identifiable {
    
    let id: String
    var name: String
    var phoneNumber: String?
    var photoUrl: URL?
    
    init(from firebaseUser: FirebaseAuth.User) throws {
        self.id = firebaseUser.uid
        self.name = firebaseUser.displayName ?? ""
        self.phoneNumber = firebaseUser.phoneNumber
        self.photoUrl = firebaseUser.photoURL
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)
        self.photoUrl = try container.decodeIfPresent(URL.self, forKey: .photoUrl)
    }
    
    init(
        id: String = UUID().uuidString,
        name: String,
        phoneNumber: String? = nil,
        photoUrl: URL? = nil
    ) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.photoUrl = photoUrl
    }
}

extension User {
    static let mocked = User(
        name: "Test User",
        phoneNumber: "0744444555",
        photoUrl: URL(string: "https://en.wikipedia.org/wiki/Lion#/media/File:Lion_waiting_in_Namibia.jpg")
    )
}
