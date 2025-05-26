//
//  ProductCardState.swift
//  Products
//
//  Created by lorenc_D_K on 11.03.2025.
//

import Combine
import UIKit

final class ProductCardState: ViewStateProtocol {
    // MARK: - Properties
    
    @Published var article: String
    @Published var loadingState: LoadingState
    @Published var position: Position
    @Published var currentSlidingStep: Int
    @Published var isImageSliderVertical: Bool
    @Published var productImages: [NetworkImage]
    @Published var actualPrice: String
    @Published var initialPrice: String
    @Published var basketLoadingState: LoadingState
    @Published var isPriceCellVisible: Bool
    @Published var isAvailableToBuy: Bool
    @Published var isAddedToBasket: Bool
    @Published var bottomSafeAreaInset: CGFloat
    @Published var priceDescription: String
    
    var shouldShowPriceInButton: Bool {
        if case .bottom = position {
            return true
        }
        return !isPriceCellVisible
    }
    
    var navigationHeaderOpacity: Double {
        switch position {
        case .bottom:
            0
        case .middle:
            0
        case .top:
            1
        }
    }
    
    var offset: Double {
        switch position {
        case .bottom:
            UIScreen.main.bounds.height - PublicConstant.initialOffset
        case .middle:
            isImageSliderVertical ? UIScreen.main.bounds.height / 2.0 : UIScreen.main.bounds.width
        case .top:
            PublicConstant.navBarHeight
        }
    }
    
    var navigationHeader: NavigationHeader.ViewState {
        .init(
            article: article,
            loadingState: loadingState,
            opacity: navigationHeaderOpacity
        )
    }
    
    var priceCell: PriceCell.ViewState {
        .init(
            name: "Серебрянные часы Bastet. Швейцарский механизм и знаменитые Белорусские стрелки", // stub data
            bages: ["НОВИНКА", "ХИТ", "ИТАЛИЯ"],
            actualPrice: actualPrice,
            initialPrice: initialPrice,
            priceDescription: priceDescription,
            position: position
        )
    }
    
    var footerButtons: FooterButtons.ViewState {
        .init(
            loadingState: loadingState,
            bottomInset: bottomSafeAreaInset,
            basketLoadingState: basketLoadingState,
            actualPrice: actualPrice,
            initialPrice: initialPrice,
            shouldShowPriceInButton: shouldShowPriceInButton,
            isAvailableToBuy: isAvailableToBuy,
            isAddedToBasket: isAddedToBasket
        )
    }
    
    var imageSliderAssembly: ImageSliderAssembly.ViewState {
        get {
            .init(
                currentStep: currentSlidingStep,
                loadingState: loadingState,
                position: position,
                initialOffset: PublicConstant.initialOffset,
                isImageSliderVertical: isImageSliderVertical,
                productImages: productImages
            )
        }
        set {
            currentSlidingStep = newValue.currentStep
        }
    }
    
    // MARK: - Lifecycle
    
    init(input: ProductCard.Input?) {
        article = input?.article ?? ""
        loadingState = .loading
        position = .bottom
        currentSlidingStep = 0
        isImageSliderVertical = true
        productImages = []
        actualPrice = ""
        initialPrice = ""
        basketLoadingState = .hide
        isPriceCellVisible = false
        isAvailableToBuy = true
        isAddedToBasket = false
        bottomSafeAreaInset = 0
        priceDescription = ""
    }
}

extension ProductCard.ViewState {
    func makeStubData() {
        article = "123456"
        productImages = [
            NetworkImage(url: URL(string: "https://g7.sunlight.net/media/content_img/0d883638ecfc48617f1fc8c4f9db4da1cae1e469.jpg")),
            NetworkImage(url: URL(string: "https://g4.sunlight.net/media/content_img/3b92c049b0de56c2cfe9266ca622e26653d6aa78.jpg")),
            NetworkImage(url: URL(string: "https://g2.sunlight.net/media/content_img/1477c4205b7b7f6472d2aaaa33e4118abd337c1d.jpg")),
        ]
        actualPrice = "14 272 ₽"
        initialPrice = "20 989 ₽"
        priceDescription = "Войдите чтобы снизить цену"
    }
}

extension ProductCard.ViewState {
    enum Position {
        case bottom
        case middle
        case top
    }
}

extension ProductCard.ViewState {
    enum PublicConstant {
        static let initialOffset = 146.0
        static let navBarHeight = 104.0
    }
}
