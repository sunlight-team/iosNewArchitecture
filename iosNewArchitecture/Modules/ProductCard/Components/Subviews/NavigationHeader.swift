//
//  NavigationHeader.swift
//  Products
//
//  Created by lorenc_D_K on 24.02.2025.
//

import SwiftUI

struct NavigationHeader: View {
    // MARK: - Nested Types

    struct ViewState {
        let article: String
        let loadingState: LoadingState
        let opacity: Double
    }

    enum Action {
        case onTapBackButton
        case onTapFavoriteButton
        case onTapShareButton
        case onTapSimilarButton
        case onTapSetsButton
    }

    // MARK: - Properties

    let state: ViewState
    let onAction: (Action) -> Void

    private var buttonBackgroundOpacity: Double {
        1 - state.opacity
    }

    private var moreButtonSize: Double {
        state.opacity == 0 ? state.opacity : state.opacity * 36
    }

    private var favoriteButtonOpacity: Double {
        switch state.loadingState {
        case .loadError,
             .loading,
             .none:
            0
        case .hide:
            1
        }
    }

    var body: some View {
        Rectangle()
            .fill(Color.white)
            .opacity(state.opacity)
            .frame(height: 104)
            .overlay(alignment: .bottom) {
                buttons
                    .padding(6)
                    .overlay {
                        Text("\(Constant.article)\(state.article)")
                            .font(.system(size: 20))
                            .opacity(state.opacity)
                            .scaleEffect(state.opacity, anchor: .bottom)
                    }
            }
    }

    private var buttons: some View {
        HStack {
            ActivityButton(
                iconName: Constant.backIcon,
                backgroundOpacity: buttonBackgroundOpacity,
                onAction: { onAction(.onTapBackButton) }
            )

            Spacer()

            HStack(spacing: 0) {
                ActivityButton(
                    iconName: Constant.favoriteIcon,
                    backgroundOpacity: buttonBackgroundOpacity,
                    onAction: { onAction(.onTapFavoriteButton) }
                )
                .opacity(favoriteButtonOpacity)
                if state.opacity > 0 {
                    moreButton
                }
            }
        }
    }

    private var moreButton: some View {
        Menu {
            MenuContent(name: Constant.shareText, iconName: Constant.shareIcon) { onAction(.onTapShareButton) }
            MenuContent(name: Constant.similarText, iconName: Constant.similarIcon) { onAction(.onTapSimilarButton) }
            MenuContent(name: Constant.setText, iconName: Constant.productSetIcon) { onAction(.onTapSetsButton) }
        } label: {
            Image(Constant.moreIcon)
                .resizable()
                .frame(width: 24, height: 24)
                .background {
                    Color.clear
                        .frame(width: 36, height: 36)
                }
        }
    }
}

extension NavigationHeader {
    private enum Constant {
        static let shareText = "Поделиться"
        static let similarText = "Похожие"
        static let setText = "Комплект"
        static let shareIcon = "shareBlack"
        static let similarIcon = "similarBlack24x24"
        static let productSetIcon = "productSetBlack24x24"
        static let moreIcon = "moreBlack24x24"
        static let favoriteIcon = "heartBlack24x24"
        static let backIcon = "backArrowBlack24x24"
        static let article = "Артикул "
    }
}
