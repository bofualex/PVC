//
//  TabBarButton.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 19.05.2023.
//

import SwiftUI

struct TabBarButton: View {
    
    @Binding var selected : TabItem
    @Binding var centerX : CGFloat
    
    var rect : CGRect
    var value: TabItem
    
    var body: some View{
        Button(
            action: {
                withAnimation(.spring()) {
                    selected = value
                    centerX = rect.midX
                }
            },
            label: {
                VStack{
                    value.icon
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 26, height: 26)
                        .foregroundColor(selected == value ? .light438BF6 : .light2B2B2B.opacity(0.3))
                        .scaleEffect(
                            .init(
                                width: selected == value ? 1.2 : 1,
                                height: selected == value ? 1.2 : 1
                            ),
                            anchor: .center
                        )
                    
                    Text(value.description)
                        .font(.rubikMedium12)
                        .foregroundColor(selected == value ? .light438BF6 : .light2B2B2B.opacity(0.3))
                        .opacity(selected == value ? 1 : 0)
                }
                .padding(.top)
                .frame(width: 70, height: 50)
                .offset(y: selected == value ? -15 : 0)
            }
        )
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        TabBarButton(
            selected: .constant(.home),
            centerX: .constant(15),
            rect: .zero,
            value: .home
        )
    }
}
