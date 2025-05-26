//
//  FooterButtons.swift
//  Products
//
//  Created by lorenc_D_K on 24.02.2025.
//

import SwiftUI

struct FooterButtons: View {
    // MARK: - Nested Types
    
    struct ViewState {
        let loadingState: LoadingState
        let bottomInset: CGFloat
        let basketLoadingState: LoadingState
        let actualPrice: String
        let initialPrice: String
        let shouldShowPriceInButton: Bool
        let isAvailableToBuy: Bool
        let isAddedToBasket: Bool
    }
    
    enum Action {
        case onTapMapButton
        case onTapBasketButton
    }
    
    // MARK: - Properties
    
    let state: ViewState
    let onAction: (Action) -> Void
    
    private var basketButtonText: String {
        guard state.isAvailableToBuy else { return Constant.watchSimilar }
        return state.isAddedToBasket ? Constant.inBasket : Constant.toBasket
    }
    
    private var bottomPadding: CGFloat {
        state.bottomInset == 0 ? 20 : 34
    }
    
    var body: some View {
        HStack(spacing: 8) {
            buttons
                .frame(height: 48)
        }
        .padding(EdgeInsets(top: 12, leading: 12, bottom: bottomPadding, trailing: 12))
        .background( Color.white )
    }
    
    @ViewBuilder
    private var basketButtonLabel: some View {
        switch state.basketLoadingState {
        case .loading:
            Spinner(lineWidth: 2.5)
        case .hide,
                .loadError(error: _),
                .none:
            basketButtonTextLabel
        }
    }
    
    private var priceLabel: some View {
        VStack(spacing: 0) {
            Text(state.actualPrice)
                .font(.system(size: 18))
            Text(state.initialPrice)
                .strikethrough(color: .gray500)
                .font(.system(size: 12))
        }
    }
    
    @ViewBuilder
    private var basketButtonTextLabel: some View {
        if !state.shouldShowPriceInButton || state.isAddedToBasket {
            HStack(spacing: 12) {
                if
                    state.isAddedToBasket,
                    state.isAvailableToBuy
                {
                    Image(.checkMarkWhite24X24)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                Text(basketButtonText)
                    .font(.system(size: 18))
            }
        } else { priceLabel }
    }
    
    @ViewBuilder
    private var buttons: some View {
        switch state.loadingState {
        case .loadError(error: _),
                .loading,
                .none:
            ForEach(0 ..< 2) { _ in
                Skeleton()
                    .clipShape(.rect(cornerRadius: 10))
            }
        case .hide:
            if state.isAvailableToBuy {
                Button {
                    onAction(.onTapMapButton)
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.gray100)
                        .overlay(
                            Text(Constant.whereToBuy)
                                .font(.system(size: 18))
                                .foregroundStyle(Color.gray900)
                        )
                }
            }
            
            Button {
                onAction(.onTapBasketButton)
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.gray900)
                    .overlay(
                        basketButtonLabel
                            .foregroundStyle(Color.white)
                    )
            }
        }
    }
}

extension FooterButtons {
    private enum Constant {
        static let whereToBuy = "Где купить"
        static let inBasket = "В корзине"
        static let toBasket = "В корзину"
        static let watchSimilar = "Посмотреть похожие"
    }
}
