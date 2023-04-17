//
//  UIKit+Utils.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 13.04.2023.
//

import Foundation
import UIKit
import SwiftUI

typealias VoidCallback = () -> Void

extension UIApplication {
    
    var safeAreaInsets: UIEdgeInsets? {
        UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last?
            .safeAreaInsets
    }
    
    func tryOpen(url: URL?) {
        guard let url, canOpenURL(url) else {
            return
        }
        self.open(url)
    }
    
    func phoneCall(_ number: String) {
        let phoneNumber = number.components(separatedBy: CharacterSet(charactersIn: "0123456789-+()").inverted).joined(separator: "")
        
        guard let url = URL(string: "tel://\(phoneNumber)") else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}


func generateHapticFeedback() {
    let generator = UIImpactFeedbackGenerator(style: .light)
    generator.impactOccurred()
}