//
//  AuthorizationView.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 24.05.2023.
//

import SwiftUI
import Combine

struct AuthorizationView: View {
    
    @EnvironmentObject private var router: AuthCoordinator.Router
    @ObservedObject var viewModel: AuthorizationViewModel

    var body: some View {
        NavigationBar(
            barType: .none,
            isBackButtonHidden: viewModel.state == .emailCheck,
            contentView: {
                content
            },
            leftButtonAction: viewModel.handleBackTapped
        )
        .fillWithDefaultScreenBackground()
        .errorDisplay(error: $viewModel.apiError)
        .onAppear {
            viewModel.router = router
        }
    }
    
    private var content: some View {
        VStack(alignment: .center, spacing: 24) {
            Spacer()
                .frame(height: 40)
            title
            subtitle
            logo
            
            VStack(spacing: 0) {
                if viewModel.state == .emailCheck {
                    email
                } else {
                    passwordField(
                        binding: $viewModel.password,
                        error: viewModel.passwordError,
                        placeholder: .generalPassword
                    )
                }
                
                if viewModel.state == .signup {
                    passwordField(
                        binding: $viewModel.reenteredPassword,
                        error: viewModel.reEnteredPasswordError,
                        placeholder: .generalReEnterPassword
                    )
                }
            }
            
            cta
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 36)
        .gesture(
            dragGesture
                .onEnded { value in
                    viewModel.handleDrag(with: value)
                }
        )
    }
    
    private var title: some View {
        Text(viewModel.state.properties.title)
            .animation(.default, value: viewModel.state)
            .font(.rubikBold24)
            .foregroundColor(.light2B2B2B)
    }
    
    private var subtitle: some View {
        Text(viewModel.state.properties.subtitle)
            .animation(.default, value: viewModel.state)
            .font(.rubikLight16)
            .foregroundColor(.light2B2B2B)
            .multilineTextAlignment(.center)
            .lineSpacing(2)
            .opacity(0.7)
    }
    
    private var email: some View {
        PlaceholderTextfield(
            text: $viewModel.email,
            placeholder: .generalEmail,
            error: viewModel.emailError,
            keyboardType: .emailAddress,
            textContentType: .emailAddress
        )
        .disabled(viewModel.isLoading)
    }
    
    private func passwordField(
        binding: Binding<String>,
        error: LocalError?,
        placeholder: String
    ) -> some View {
        PlaceholderTextfield(
            text: binding,
            placeholder: placeholder.capitalized,
            error: error,
            isSecureTextEntry: true,
            textContentType: .password
        )
        .disabled(viewModel.isLoading)
    }
    
    private var cta: some View {
        Buttons.FilledButton(
            title: viewModel.state.properties.ctaText.capitalized,
            isEnabled: viewModel.email.isValidEmail,
            isLoading: viewModel.isLoading,
            action: viewModel.handleCTATapped
        )
        .animation(.default, value: viewModel.state)
    }
    
    private var logo: some View {
        Image.generalLogo
            .resizable()
            .frame(size: .init(edgeLength: 150))
            .clipped()
    }
    
    private var dragGesture: DragGesture {
        DragGesture(
            minimumDistance: 20,
            coordinateSpace: .global
        )
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView(
            viewModel: .init(
                authService: AuthenticationServiceMock()
            )
        )
        .environmentObject(AuthCoordinator.mockedRouter)
    }
}
