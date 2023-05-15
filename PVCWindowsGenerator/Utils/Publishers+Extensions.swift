//
//  Publishers+Extensions.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 13.04.2023.
//

import UIKit
import Combine

extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification).map({$0.keyboardHeight})
        let willChangeFrame = NotificationCenter.default.publisher(for: UIApplication.keyboardWillChangeFrameNotification).map({$0.keyboardHeight})
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification).map({_ in CGFloat(0)})
        return MergeMany(willShow, willChangeFrame, willHide).eraseToAnyPublisher()
    }
    
    static var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter
                .default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },
            NotificationCenter
                .default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false })
        .eraseToAnyPublisher()
    }
}

private extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
