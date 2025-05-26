//
//  ActivityButton.swift
//  Products
//
//  Created by lorenc_D_K on 26.02.2025.
//

import SwiftUI

struct ActivityButton: View {
    let iconName: String
    let backgroundOpacity: Double
    let onAction: () -> Void
    
    var body: some View {
        Button {
            onAction()
        } label: {
            ZStack {
                Color.clear
                    .frame(square: 44)
                
                Circle()
                    .fill(
                        Color.white.opacity(0.56)
                            .opacity(backgroundOpacity)
                    )
                    .frame(width: 36)
                
                Image(iconName)
                    .resizable()
                    .frame(square: 24)
            }
            .contentShape(Rectangle())
        }
    }
}
