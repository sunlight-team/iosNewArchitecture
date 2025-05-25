//
//  BadgeCell.swift
//  Products
//
//  Created by lorenc_D_K on 28.02.2025.
//

import SwiftUI

struct BadgeCell: View {
    let name: String

    var body: some View {
        Text(name)
            .font(.system(size: 12))
            .foregroundStyle(.white)
            .padding(EdgeInsets(top: 1, leading: 6, bottom: 1, trailing: 6))
            .background(
                Color.gray700
                    .clipShape(.rect(cornerRadius: 4))
            )
    }
}
