//
//  View + Extension.swift
//  SunlightArchitectureIOS
//
//  Created by lorenc_D_K on 05.05.2025.
//

import SwiftUI

extension View {
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    @ViewBuilder
    func frame(square size: CGFloat, alignment: Alignment = .center) -> some View {
        frame(width: size, height: size, alignment: alignment)
    }
    
    @ViewBuilder func valueChanged<T: Equatable>(value: T, onChange: @escaping (T) -> Void) -> some View {
        if #available(iOS 17.0, *) {
            self.onChange(of: value) { _, newValue in
                onChange(newValue)
            }
        } else {
            self.onChange(of: value) { value in
                onChange(value)
            }
        }
    }
    
}
