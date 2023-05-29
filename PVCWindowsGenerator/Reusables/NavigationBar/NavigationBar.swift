//
//  NavigationBar.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 13.04.2023.
//

import SwiftUI

struct NavigationBar<
    ContentView: View,
    RightView: View
>: View {
    
    @Environment(\.safeAreaInset)
    private var safeAreaInsets: EdgeInsets
    
    let barType: BarType
    let leftButtonAction: VoidCallback?
    var isBackButtonHidden = false
    
    @ViewBuilder
    var contentView: ContentView
    @ViewBuilder
    var rightView: RightView
    
    var body: some View {
        contentView
            .ignoresSafeArea(edges: .all)
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .top) {
                navigationContent
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 12)
                //                    .background(
                //                        LinearGradient(
                //                            colors: [
                //                                .lightC34246.opacity(0.3),
                //                                .light438BF6.opacity(0.3)
                //                            ],
                //                            startPoint: .top,
                //                            endPoint: .bottom
                //                        )
                //                        Color.white
                //                            .overlay(.ultraThinMaterial)
                //                        .roundedCorners(.bottomCorners, radius: 24)
                //                            .ignoresSafeArea(.container, edges: .top)
                //                    )
            }
            .navigationBarHidden(true)
    }
    
    @ViewBuilder
    private var navigationContent: some View {
        ZStack {
            backButtonView
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            
            switch barType {
            case .logo(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 34)
                    .clipped()
            case .title(let text):
                titleView(text: text)
            case .none:
                EmptyView()
            }
            
            rightView
                .frame(
                    maxWidth: .infinity,
                    alignment: .trailing
                )
        }
    }
    
    @ViewBuilder
    private var backButtonView: some View {
        if !isBackButtonHidden {
            Buttons.BackButton(action: leftButtonAction)
        }
    }
    
    private func titleView(text: String) -> some View {
        Text(text)
            .font(.rubikMedium18)
            .lineLimit(2)
            .minimumScaleFactor(0.8)
            .foregroundColor(.light2B2B2B)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    private struct TitleNavigationBarPreview: View {
        
        private let testText = "No symbol named 'eye.fi' found in system symbol set No symbol named 'eye.fil' found in system symbol set No symbol named 'eye.fil' found in system symbol set No symbol named 'eye.fi' found in system symbol set No symbol named 'eye.f' found in system symbol set"
        
        var body: some View {
            NavigationBar(
                barType: .title(title: .signupScreenTitle),
                leftButtonAction: nil,///.logo(image: .generalLogo),
                contentView: {
                    ScrollView {
                        VStack {
                            Text(testText)
                            Text(testText)
                            Text(testText)
                            Text(testText)
                            Text(testText)
                        }
                    }
                    .fillWithDefaultScreenBackground()
                    .padding(.horizontal)
                },
                rightView: {
                    Image(systemName: "eye.fill")
                        .foregroundColor(.lightF5EDEC)
                }
            )
        }
    }
    
    static var previews: some View {
        TitleNavigationBarPreview()
    }
}
