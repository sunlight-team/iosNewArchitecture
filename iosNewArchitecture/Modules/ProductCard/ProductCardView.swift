//
//  ProductCardView.swift
//  Products
//
//  Created by lorenc_D_K on 11.03.2025.
//

import SwiftUI

struct ProductCardView: View, ViewProtocol {
    @ObservedObject var state: ProductCard.ViewState
    let reducer: Reducer<ProductCard.ViewModel>

    private var isDragGestureEnabled: Bool {
        if case .bottom = state.position {
            return true
        }
        return false
    }

    init(state: ProductCard.ViewState, reducer: Reducer<ProductCard.ViewModel>) {
        self.state = state
        self.reducer = reducer
    }

    var body: some View {
        ProductCardViewLayout(
            header: { header },
            sideButtons: { sideButtons },
            slider: { slider },
            content: { content },
            footer: { footer(geometry: $0) }
        )
        .onAppear { reducer(.viewDidLoad) }
        .animation(.easeInOut(duration: 1.0), value: state.position)
        .animation(.default, value: state.isPriceCellVisible)
        .animation(.default, value: state.isAddedToBasket)
        .animation(.default, value: state.basketLoadingState)
        .animation(.default, value: state.loadingState)
    }

    private var header: some View {
        NavigationHeader(
            state: state.navigationHeader,
            onAction: { reducer(.onNavigationHeaderAction($0)) }
        )
    }

    private var sideButtons: some View {
        SideButtons(
            position: state.position,
            loadingState: state.loadingState,
            onAction: { reducer(.onSideButtonsAction($0)) }
        )
        .opacity(1 - state.navigationHeaderOpacity)
    }

    private var slider: some View {
        ImageSliderAssembly(
            state: $state.imageSliderAssembly,
            onAction: { reducer(.onImageSliderAction($0)) }
        )
    }

    private var content: some View {
        ProductCardList(state: state, reducer: reducer)
            .offset(y: state.offset)
    }

    private func footer(geometry: GeometryProxy) -> some View {
        FooterButtons(
            state: state.footerButtons,
            onAction: { reducer(.onFooterButtonsAction($0)) }
        )
        .onAppear {
            reducer(.setBottomSafeAreaInset(geometry.safeAreaInsets.bottom))
        }
        .animation(.easeInOut(duration: 1.0), value: state.position)
        .animation(.default, value: state.isPriceCellVisible)
        .animation(.default, value: state.isAddedToBasket)
        .animation(.default, value: state.basketLoadingState)
        .animation(.default, value: state.loadingState)
    }
}
