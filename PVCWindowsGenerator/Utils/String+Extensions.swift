//
//  String+Extensions.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 03.05.2023.
//

import Foundation

extension String {
    private enum Regex: String {
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case name = "\\w{7,18}"
        /*
         ^                         Start anchor
         (?=.*[A-Z].*[A-Z])        Ensure string has one uppercase letter.
         (?=.*[!@#$&*])            Ensure string has one special case letter.
         (?=.*[0-9].*[0-9])        Ensure string has one digit.
         .{8}                      Ensure string is of length 8.
         $                         End anchor.
         */
        case password = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9]).{8}$"
        
        func isValid(for string: String) -> Bool {
            let test = NSPredicate(format: "SELF MATCHES %@", rawValue)
            
            return test.evaluate(with: string)
        }
    }

    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    var containsEmoji: Bool { contains { $0.isEmoji } }
    
    var isValidEmail: Bool {
        Regex.email.isValid(for: self)
    }
    
    var isValidName: Bool {
        Regex.name.isValid(for: self) && !self.containsEmoji && (1...141).contains(count)
    }
    
    var isValidPassword: Bool {
        Regex.password.isValid(for: self)
    }
}

extension Character {
    /// A simple emoji is one scalar and presented to the user as an Emoji
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }
    
    /// Checks if the scalars will be merged into an emoji
    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }
    
    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}
