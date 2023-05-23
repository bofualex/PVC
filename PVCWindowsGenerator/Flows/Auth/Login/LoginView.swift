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
            barType: .title(title: .loginScreenTitle),
            contentView: {
                content
            },
            leftButtonAction: {
                router.pop()
            }
        )
        .fillBackground(.lightF5EDEC)
        .errorDisplay(error: $viewModel.error)
        .onAppear {
            viewModel.router = router
        }
    }
    
    private var content: some View {
        VStack(alignment: .center, spacing: 24) {
            password
            cta
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 36)
    }
    
    private var title: some View {
        Text(verbatim: .signupScreenTitle)
            .font(.rubikBlack28)
            .foregroundColor(.light2B2B2B)
    }
    
    private var password: some View {
        PlaceholderTextfield(
            text: $viewModel.password,
            placeholder: .generalPassword.capitalized,
            isSecureTextEntry: true,
            backgroundColor: .lightFFFFFF
        )
        .disabled(viewModel.isLoading)
    }

    private var cta: some View {
        Buttons.FilledButton(
            title: .generalLogin.capitalized,
            isLoading: viewModel.isLoading,
            action: viewModel.handleLoginTapped
        )
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            viewModel: .init(
                authService: AuthenticationServiceMock(),
                email: ""
            )
        )
        .environmentObject(AuthCoordinator.mockedRouter)
    }
}
