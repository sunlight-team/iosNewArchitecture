//
//  ProductCardViewModel.swift
//  Products
//
//  Created by lorenc_D_K on 11.03.2025.
//

import Foundation

actor ProductCardViewModel: ViewModelProtocol {
    
    // MARK: - Nested Types
    
    enum Action {
        case viewDidLoad
        case dismiss
        case updatePosition(CGFloat)
        case setPriceCellVisible(Bool)
        case saveLastSlidingStep(Int)
        case setBottomSafeAreaInset(CGFloat)
        case onNavigationHeaderAction(NavigationHeader.Action)
        case onSideButtonsAction(SideButtons.Action)
        case onImageSliderAction(ImageSliderAssembly.Action)
        case onFooterButtonsAction(FooterButtons.Action)
        case onPriceCellAction(PriceCell.Action)
    }
    
    
    // MARK: - Private Properties
    
    private let router: ProductCard.Router?
    private let state: ProductCard.ViewState
    private let input: ProductCard.Input?
    private let output: ProductCard.Output?
    private var isAnimating = false
    
    // MARK: - Initializer
    
    init(
        state: ProductCard.ViewState,
        input: ProductCard.Input?,
        output: ProductCard.Output?,
        router: ProductCard.Router?
    ) {
        self.state = state
        self.input = input
        self.output = output
        self.router = router
    }
    
    // MARK: - Internal Methods
    
    func handle(_ action: Action) async {
        switch action {
        case .viewDidLoad:
            await viewDidLoad()
        case .dismiss:
            await dismiss()
        case let .updatePosition(transition):
            await updatePosition(for: transition)
        case let .setPriceCellVisible(isPriceCellVisible):
            await setPriceCellVisible(isPriceCellVisible)
        case let .saveLastSlidingStep(step):
            await saveSlidingStep(step)
        case let .setBottomSafeAreaInset(inset):
            await setBottomSafeAreaInset(inset)
        case let .onNavigationHeaderAction(action):
            await handleNavigationHeader(action: action)
        case let .onSideButtonsAction(action):
            await handleSideButtons(action: action)
        case let .onImageSliderAction(action):
            await handleImageSlider(action: action)
        case let .onFooterButtonsAction(action):
            await handleFooterButtons(action: action)
        case let .onPriceCellAction(action):
            await handlePriceCell(action: action)
        }
    }
}

// MARK: - Private Methods

extension ProductCard.ViewModel {
    private func handleNavigationHeader(action: NavigationHeader.Action) async {
        switch action {
        case .onTapBackButton:
            await dismiss()
        case .onTapFavoriteButton:
            print(action)
        case .onTapShareButton:
            print(action)
        case .onTapSimilarButton:
            print(action)
        case .onTapSetsButton:
            print(action)
        }
    }
    
    private func handleSideButtons(action: SideButtons.Action) async {
        switch action {
        case .onTapShareButton:
            print(action)
        case .onTapSimilarButton:
            print(action)
        case .onTapSetsButton:
            print(action)
        }
    }
    
    private func handleFooterButtons(action: FooterButtons.Action) async {
        switch action {
        case .onTapMapButton:
            await switchPriceStyle()
        case .onTapBasketButton:
            await addToBasket()
        }
    }
    
    private func handlePriceCell(action: PriceCell.Action) async {
        switch action {
        case let .onSetPriceCellVisible(isVisible):
            await setPriceCellVisible(isVisible)
        }
    }
    
    private func handleImageSlider(action: ImageSliderAssembly.Action) async {
        switch action {
        case let .onTapSlider(index):
            print(index)
        case let .onTapReview(index):
            print(index)
        case let .onSaveSlidingStep(step):
            await saveSlidingStep(step)
        }
    }
    
    private func setInitialState() async { 
        await state.update { $0.makeStubData() }
    }
    
    private func setBottomSafeAreaInset(_ inset: CGFloat) async {
        await state.update { $0.bottomSafeAreaInset = inset }
    }
    
    private func dismiss() async {
        await router?.dismiss()
    }
    
    private func saveSlidingStep(_ step: Int) async {
        try? await Task.sleep(seconds: 0.1)
        await state.update {
            $0.currentSlidingStep = step
        }
    }
    
    private func setPosition() async {
        if await !state.isImageSliderVertical {
            await state.update { $0.position = .middle }
        }
    }
    
    private func setPriceCellVisible(_ isVisible: Bool) async {
        await state.update { state in
            state.isPriceCellVisible = isVisible
        }
    }
    
    private func addToBasket() async {
        await state.update {
            $0.basketLoadingState = .loading
        }
        try? await Task.sleep(seconds: 1.5)
        await state.update { state in
            state.isAddedToBasket.toggle()
            state.basketLoadingState = .hide
        }
    }
    
    private func viewDidLoad() async {
        try? await Task.sleep(seconds: 2)
        await setInitialState()
        await state.update { $0.loadingState = .hide }
        await setPosition()
    }
    
    private func updatePosition(for transition: CGFloat) async {
        guard !isAnimating else { return }
        isAnimating = true
        let position = await handle(transition: transition)
        await state.update { $0.position = position }
        try? await Task.sleep(seconds: Constant.animationDuration)
        isAnimating = false
    }
    
    private func handle(transition: CGFloat) async -> ProductCard.ViewState.Position {
        switch await (state.position, transition) {
        case (.bottom, 0...):
                .middle
        case (.middle, ...0):
            await state.isImageSliderVertical ? .bottom : .middle
        case (.middle, 0...):
                .top
        case (.top, ...0):
                .middle
        default:
            await state.position
        }
    }
    
    private func switchPriceStyle() async {
        await state.update { $0.isPriceCellVisible.toggle() }
    }
}



extension ProductCard.ViewModel {
    private enum Constant {
        static let animationDuration = 1.0
    }
}
