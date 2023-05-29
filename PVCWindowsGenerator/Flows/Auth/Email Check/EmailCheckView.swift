//
//  EmailCheckView.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 11.04.2023.
//

import SwiftUI
import Stinsen

struct EmailCheckView: View {
    
    @EnvironmentObject private var router: AuthCoordinator.Router
    @ObservedObject var viewModel: EmailCheckViewModel

    var body: some View {
        NavigationBar(
            barType: .none,
            isBackButtonHidden: true,
            contentView: {
                content
            }
        )
        .fillWithDefaultScreenBackground()
        .errorDisplay(error: $viewModel.error)
        .onAppear {
            viewModel.router = router
        }
    }
    
    private var content: some View {
        VStack(alignment: .center, spacing: 24) {
            title
            subtitle
            logo
            email
            cta
        }
        .padding(.horizontal, 24)
        .padding(.top, 36)
    }
    
    private var title: some View {
        Text(verbatim: .emailCheckScreenTitle)
            .font(.rubikBold24)
            .foregroundColor(.light2B2B2B)
    }
    
    private var subtitle: some View {
        Text(verbatim: .emailCheckScreenSubtitle)
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
            keyboardType: .emailAddress,
            textContentType: .emailAddress,
            backgroundColor: .lightFFFFFF
        )
        .disabled(viewModel.isLoading)
    }
    
    private var cta: some View {
        Buttons.FilledButton(
            title: .generalContinu.capitalized,
            isEnabled: viewModel.email.isValidEmail,
            isLoading: viewModel.isLoading,
            action: viewModel.checkEmail
        )
    }
    
    private var logo: some View {
        Image.generalLogo
            .resizable()
            .frame(size: .init(edgeLength: 150))
            .clipped()
    }
}

struct EmailCheckView_Previews: PreviewProvider {
    
    static var previews: some View {
        EmailCheckView(
            viewModel: .init(
                authService: AuthenticationServiceMock()
            )
        )
        .environmentObject(AuthCoordinator.mockedRouter)
    }
}
