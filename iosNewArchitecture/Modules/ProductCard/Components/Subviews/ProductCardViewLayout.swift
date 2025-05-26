//
//  ProductCardViewLayout.swift
//  Products
//
//  Created by lorenc_D_K on 21.03.2025.
//

import SwiftUI

struct ProductCardViewLayout<Header, SideButtons, Footer, Slider, Content>: View
where Header: View, SideButtons: View, Footer: View, Slider: View, Content: View
{
    @ViewBuilder var header: () -> Header
    @ViewBuilder var sideButtons: () -> SideButtons
    @ViewBuilder var slider: () -> Slider
    @ViewBuilder var content: () -> Content
    @ViewBuilder var footer: (_ geometry: GeometryProxy) -> Footer
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0) {
                    slider()
                    Spacer()
                }
                
                content()
                
                VStack(spacing: 0) {
                    header()
                    
                    HStack {
                        Spacer()
                        sideButtons()
                    }
                    
                    Spacer()
                    footer(geometry)
                }
            }
            .ignoresSafeArea()
        }
    }
}
