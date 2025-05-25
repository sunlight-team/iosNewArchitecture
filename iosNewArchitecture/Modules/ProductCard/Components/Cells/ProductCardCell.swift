//
//  ProductCardCell.swift
//  Products
//
//  Created by lorenc_D_K on 24.02.2025.
//

import SwiftUI

struct ProductCardCell: View {
    let index: Int

    var body: some View {
        ZStack {
            Color.white
            Text("Cell example \(index)")
                .font(.largeTitle)
        }
        .frame(height: 100)
    }
}
