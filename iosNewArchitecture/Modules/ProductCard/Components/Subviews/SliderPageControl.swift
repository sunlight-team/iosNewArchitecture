//
//  SliderPageControl.swift
//  Products
//
//  Created by lorenc_D_K on 28.02.2025.
//

import SwiftUI

struct SliderPageControl: View {
    let totalSteps: Int
    let currentStep: Int
    let widthRatio: CGFloat = 0.3
    
    var height: CGFloat {
        totalSteps > 1 ? 4 : 0
    }
    
    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var offset: CGFloat {
        (1 - widthRatio) * screenWidth * CGFloat(currentStep) / CGFloat(totalSteps - 1)
    }
    
    var body: some View {
        Color.clear
            .frame(height: height)
            .overlay(alignment: .leading) {
                Color.gray800
                    .frame(width: screenWidth * widthRatio)
                    .offset(x: offset)
            }
    }
}
