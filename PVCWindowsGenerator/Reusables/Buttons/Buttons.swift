//
//  Buttons.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 13.04.2023.
//

import SwiftUI

struct Buttons {}

struct Buttons_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            HStack {
                Buttons.BackButton(action: {})
                
                Buttons.FilledButton(
                    title: "Save",
                    action: nil
                )
                Buttons.BorderedButton(
                    title: "Save all"
                )
            }
            HStack {
                Buttons.FilledButton(
                    title: "Save",
                    isEnabled: false,
                    action: nil
                )
                Buttons.BorderedButton(
                    title: "Save",
                    isEnabled: false
                )
            }
            HStack {
                Buttons.FilledButton(
                    title: "Show",
                    isLoading: true,
                    action: nil
                )
                Buttons.BorderedButton(
                    title: "Show",
                    isLoading: true
                )
            }
            
            HStack {
                Buttons.VerticalImageTextButton(
                    title: "Something",
                    imageName: "eye.slash",
                    isSystemImage: true
                )
                Buttons.VerticalImageTextButton(
                    title: "VerticalImageTextButton",
                    imageName: "closeIcon"
                )
            }
 
            HStack {
                Buttons.TextButton(
                    title: "Reseteaza"
                )
                Buttons.TextButton(
                    title: "AnyText"
                )
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 22)
    }
}
