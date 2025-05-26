//
//  ProductCardList.swift
//  Products
//
//  Created by lorenc_D_K on 24.02.2025.
//



import SwiftUI

struct ProductCardList<S, R>: View where S: ProductCard.ViewState, R: Reducer<ProductCard.ViewModel> {
    @ObservedObject var state: S
    let reducer: R
    let dataSource: [Int] = Array(0 ... 20)
    private let coordinateSpaceName = UUID()
    
    private var axis: Axis.Set {
        switch state.position {
        case .bottom,
                .middle:
            []
        case .top:
                .vertical
        }
    }
    
    private var isDragGestureEnabled: Bool {
        if case .top = state.position {
            return false
        }
        return true
    }
    
    private var bottomPadding: CGFloat {
        Constant.navBarHeight + Constant.footerButtonsHeight + (state.bottomSafeAreaInset == 0 ? 20 : 34)
    }
    
    var body: some View {
        ZStack {
            Color.white
            mainView
        }
    }
    
    @ViewBuilder
    private var mainView: some View {
        switch state.loadingState {
        case
                .loading:
            VStack {
                Skeleton()
                    .clipShape(.rect(cornerRadius: 10))
                    .frame(height: 20)
                    .padding(EdgeInsets(top: 21, leading: 71, bottom: 21, trailing: 71))
                
                Spacer()
            }
        case .hide,
                .loadError(error: _),
                .none:
            
            let dragGesture = DragGesture(minimumDistance: 20, coordinateSpace: .global)
                .onChanged { value in
                    reducer(.updatePosition(-value.translation.height))
                }
            
            ScrollView(axis, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(dataSource, id: \.self) { index in
                        getCell(for: index)
                    }
                }
                .background(
                    GeometryReader { proxy in
                        Color.clear.preference(
                            key: ViewOffsetKey.self,
                            value: -proxy.frame(in: .named(coordinateSpaceName)).origin.y
                        )
                    }
                )
                .onPreferenceChange(ViewOffsetKey.self) { value in
                    if value < Constant.dragDownOffset {
                        reducer(.updatePosition(value))
                    }
                }
            }
            .coordinateSpace(name: coordinateSpaceName)
            .gesture(dragGesture, isEnabled: isDragGestureEnabled)
            .padding(.bottom, bottomPadding)
        }
    }
    
    @ViewBuilder
    private func getCell(for index: Int) -> some View {
        if index == 0 {
            PriceCell(
                state: state.priceCell,
                onAction: { reducer(.onPriceCellAction($0)) }
            )
        } else if index % 2 == 0 {
            ProductCardCell(index: index)
        } else {
            CellDivider()
        }
    }
}

extension ProductCardList {
    private enum Constant {
        static var dragDownOffset: CGFloat { -70.0 }
        static var navBarHeight: CGFloat { 104.0 }
        static var footerButtonsHeight: CGFloat { 60.0 }
        static var minBottomOffset: CGFloat { 20.0 }
        static var maxBottomOffset: CGFloat { 34 }
    }
}
