//
//  TabBarView.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 18.05.2023.
//

import SwiftUI

struct AnimatableTabBarView: View {
    
    var tabItems: [TabItem]
    
    @State private var centerX : CGFloat = 0
    
    @Environment(\.safeAreaInset) var safeAreaInset
    
    @Binding var selected: TabItem
    
    init(tabItems: [TabItem], selected: Binding<TabItem>) {
        UITabBar.appearance().isHidden = true
        self.tabItems = tabItems
        self._selected = selected
    }
    
    var body: some View {
        HStack(spacing: 0){
            ForEach(tabItems,id: \.self){value in
                GeometryReader{ proxy in
                    TabBarButton(
                        selected: $selected,
                        centerX: $centerX,
                        rect: proxy.frame(in: .global),
                        value: value
                    )
                    .onAppear {
                        if value == tabItems.first {
                            centerX = proxy.frame(in: .global).midX
                        }
                    }
                }
                .frame(width: 70, height: 50)
                
                if value != tabItems.last{
                    Spacer(minLength: 0)
                }
            }
        }
        .padding(.horizontal,25)
        .padding(.top)
        .padding(.bottom, safeAreaInset.bottom == 0 ? 15 : safeAreaInset.bottom)
        .background(
            .ultraThinMaterial,
            in: TabBarShape(centerX: centerX)
        )
        .shadow(
            color: Color.black.opacity(0.1),
            radius: 5,
            x: 0,
            y: -5
        )
        .padding(.top, -15)
        .ignoresSafeArea(.all, edges: .horizontal)
    }
}

struct AnimatableTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatableTabBarView(
            tabItems: TabItem.allCases,
            selected: .constant(.home)
        )
    }
}
