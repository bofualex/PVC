//
//  LoginView.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 11.04.2023.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject private var router: AuthCoordinator.Router
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        NavigationBar(
            barType: .title(title: "Login"),
            contentView: {
                Text("login")
            },
            leftButtonAction: {
                router.pop()
            }
        )
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            viewModel: .init(
                authService: AuthenticationServiceMock()
            )
        )
    }
}
