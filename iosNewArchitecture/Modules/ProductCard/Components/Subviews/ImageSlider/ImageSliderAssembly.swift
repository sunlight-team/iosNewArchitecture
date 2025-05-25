//
//  ImageSliderAssembly.swift
//  Products
//
//  Created by lorenc_D_K on 25.02.2025.
//


import SwiftUI

struct ImageSliderAssembly: View {
    // MARK: - Nested Types
    
    struct ViewState {
        var currentStep: Int
        let loadingState: LoadingState
        let position: ProductCard.ViewState.Position
        let initialOffset: CGFloat
        let isImageSliderVertical: Bool
        let productImages: [NetworkImage]
    }

    enum Action {
        case onTapSlider(Int)
        case onTapReview(Int)
        case onSaveSlidingStep(Int)
    }

    // MARK: - Properties

    @Binding var state: ViewState
    let onAction: (Action) -> Void

    private var sliderFrameHeight: CGFloat {
        switch state.position {
        case .bottom:
            UIScreen.main.bounds.height - state.initialOffset
        case .middle:
            state.isImageSliderVertical ? UIScreen.main.bounds.height / 2.0 : UIScreen.main.bounds.width
        case .top:
            0
        }
    }

    private var assemblyFrameHeight: CGFloat {
        if case .bottom = state.position {
            UIScreen.main.bounds.height - state.initialOffset
        } else {
            state.isImageSliderVertical ? UIScreen.main.bounds.height - state.initialOffset : UIScreen.main.bounds.width
        }
    }

    private var isNeedBottomSpacer: Bool {
        switch state.position {
        case .bottom:
            false
        case .middle:
            state.isImageSliderVertical
        case .top:
            true
        }
    }

    var body: some View {
        mainView
            .frame(height: assemblyFrameHeight)
    }

    @ViewBuilder
    private var mainView: some View {
        switch state.loadingState {
        case .loadError(error: _),
             .loading,
             .none:
            skeleton
        case .hide:
            assembly
        }
    }

    private var skeleton: some View {
        Skeleton()
            .overlay {
                Image(.sunlightLogoGray124X115)
            }
    }

    private var assembly: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                ImageSlider(
                    currentStep: $state.currentStep,
                    media: state.productImages,
                    onTapSlider: { onAction(.onTapSlider($0)) },
                    onSaveSlidingStep: { onAction(.onSaveSlidingStep($0)) }
                )
                .frame(height: sliderFrameHeight)
                if isNeedBottomSpacer { Spacer() }
            }

            SliderPageControl(totalSteps: state.productImages.count, currentStep: state.currentStep)
        }
    }
}
