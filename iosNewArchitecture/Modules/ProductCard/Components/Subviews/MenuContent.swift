//
//  MenuContent.swift
//  Products
//
//  Created by lorenc_D_K on 27.02.2025.
//

import SwiftUI

struct MenuContent: View {
    let name: String
    let iconName: String
    let onAction: () -> Void

    var body: some View {
        Button {
            onAction()
        } label: {
            HStack {
                Text(name)
                    .font(.system(size: 18))
                Image(iconName)
            }
        }
    }
}
