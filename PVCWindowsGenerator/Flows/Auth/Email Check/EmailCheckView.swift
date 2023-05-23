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
            barType: .logo(image: .generalLogo),
            isBackButtonHidden: true,
            contentView: {
                content
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
            title
            email
            cta
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 36)
    }
    
    private var title: some View {
        Text(verbatim: .emailCheckScreenTitle)
            .font(.rubikBlack28)
            .foregroundColor(.light2B2B2B)
    }
    
    private var email: some View {
        PlaceholderTextfield(
            text: $viewModel.email,
            placeholder: .generalEmail,
            backgroundColor: .lightFFFFFF
        )
        .disabled(viewModel.isLoading)
    }
    
    private var cta: some View {
        Buttons.FilledButton(
            title: .generalContinu.capitalized,
            isLoading: viewModel.isLoading,
            action: viewModel.checkEmail
        )
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
