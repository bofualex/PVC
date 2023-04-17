//
//  EmailCheckView.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 11.04.2023.
//

import SwiftUI

struct EmailCheckView: View {
    
    @EnvironmentObject private var router: AuthCoordinator.Router
    @ObservedObject var viewModel: EmailCheckViewModel

    var body: some View {
        NavigationBar(
            barType: .title(title: "Intră sau Creează Cont"),
            isBackButtonHidden: true,
            contentView: {
                Button("test nav") {
                    router.route(to: \.loginView)
                }
            }
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
    }
}
