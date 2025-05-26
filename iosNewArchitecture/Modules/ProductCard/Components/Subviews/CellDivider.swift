//
//  CellDivider.swift
//  UICSunlight
//
//  Created by lorenc_D_K on 21.03.2025.
//

import SwiftUI

struct CellDivider: View {
    
    var body: some View {
        VStack(spacing: 12) {
            Rectangle()
                .foregroundStyle(Color.white)
                .frame(height: 20)
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
            
            Rectangle()
                .foregroundStyle(Color.white)
                .frame(height: 20)
                .cornerRadius(20, corners: [.topLeft, .topRight])
        }
        .background { Color.gray100 }
    }
}
