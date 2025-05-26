//
//  PriceCell.swift
//  Products
//
//  Created by lorenc_D_K on 28.02.2025.
//

import SwiftUI

struct PriceCell: View {
    // MARK: - Nested Types
    
    struct ViewState {
        let name: String
        let bages: [String]
        let actualPrice: String
        let initialPrice: String
        let priceDescription: String
        let position: ProductCard.ViewState.Position
    }
    
    enum Action {
        case onSetPriceCellVisible(Bool)
    }
    
    // MARK: - Properties
    
    let state: ViewState
    let onAction: (Action) -> Void
    
    private var nameAlignment: TextAlignment {
        switch state.position {
        case .bottom:
                .center
        case .middle,
                .top:
                .leading
        }
    }
    
    private var lineLimit: Int? {
        if case .bottom = state.position {
            return 1
        } else {
            return nil
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            badges
                .transition(.opacity)
            Text(state.name)
                .lineLimit(lineLimit)
                .multilineTextAlignment(nameAlignment)
                .font(.system(size: 16))
                .frame(maxWidth: .infinity)
            
            Text(state.actualPrice)
                .font(.system(size: 26, weight: .bold))
            
            Text(state.priceDescription)
                .foregroundStyle(Color.infoBlue500)
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
        .background(Color.white)
        .onAppear { onAction(.onSetPriceCellVisible(true)) }
        .onDisappear { onAction(.onSetPriceCellVisible(false)) }
    }
    
    @ViewBuilder
    private var badges: some View {
        switch state.position {
        case .bottom:
            EmptyView()
        case .middle,
                .top:
            ScrollView(.horizontal) {
                HStack(spacing: 4) {
                    ForEach(state.bages, id: \.self) {
                        BadgeCell(name: $0)
                    }
                }
            }
        }
    }
}
