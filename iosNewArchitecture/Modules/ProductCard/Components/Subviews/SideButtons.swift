//
//  SideButtons.swift
//  Products
//
//  Created by lorenc_D_K on 27.02.2025.
//


import SwiftUI

struct SideButtons: View {
    // MARK: - Nested Types

    enum Action {
        case onTapShareButton
        case onTapSimilarButton
        case onTapSetsButton
    }

    // MARK: - Properties

    let position: ProductCard.ViewState.Position
    let loadingState: LoadingState
    let onAction: (Action) -> Void

    private var opacity: Double {
        switch position {
        case .bottom,
             .middle:
            1
        case .top:
            0
        }
    }

    var body: some View {
        switch loadingState {
        case .hide,
             .loadError,
             .none:
            VStack(spacing: 6) {
                ActivityButton(iconName: Constant.shareIcon, backgroundOpacity: 1) { onAction(.onTapShareButton) }
                ActivityButton(iconName: Constant.similarIcon, backgroundOpacity: 1) { onAction(.onTapSimilarButton) }
                ActivityButton(iconName: Constant.productSetIcon, backgroundOpacity: 1) { onAction(.onTapSetsButton) }
            }
            .padding(.trailing, 6)
            .opacity(opacity)
        case .loading:
            EmptyView()
        }
    }
}

extension SideButtons {
    private enum Constant {
        static let shareIcon = "shareBlack"
        static let similarIcon = "similarBlack24x24"
        static let productSetIcon = "productSetBlack24x24"
    }
}
