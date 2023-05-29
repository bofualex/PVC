//
//  SignupView.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 04.05.2023.
//

import SwiftUI

struct SignupView: View {
    
    @EnvironmentObject private var router: AuthCoordinator.Router
    @ObservedObject var viewModel: SignupViewModel
    
    var body: some View {
        NavigationBar(
            barType: .title(title: .signupScreenTitle),
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
            VStack(alignment: .center, spacing: 0) {
                password
                reEnterPassword
            }
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
            textContentType: .password,
            backgroundColor: .lightFFFFFF
        )
        .disabled(viewModel.isLoading)
    }
    
    private var reEnterPassword: some View {
        PlaceholderTextfield(
            text: $viewModel.reenteredPassword,
            placeholder: .generalReEnterPassword.capitalized,
            isSecureTextEntry: true,
            textContentType: .password,
            backgroundColor: .lightFFFFFF
        )
        .disabled(viewModel.isLoading)
    }
    
    private var cta: some View {
        Buttons.FilledButton(
            title: .generalSignup.capitalized,
            isLoading: viewModel.isLoading,
            action: viewModel.handleSignupTapped
        )
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(
            viewModel: .init(
                authService: AuthenticationServiceMock(),
                email: ""
            )
        )
        .environmentObject(AuthCoordinator.mockedRouter)
    }
}
