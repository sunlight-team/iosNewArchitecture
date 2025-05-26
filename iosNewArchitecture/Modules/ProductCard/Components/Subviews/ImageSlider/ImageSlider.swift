//
//  ImageSlider.swift
//  Products
//
//  Created by lorenc_D_K on 05.03.2025.
//

import SwiftUI

struct ImageSlider: View {
    @Binding var currentStep: Int
    let media: [NetworkImage]
    let onTapSlider: (Int) -> Void
    let onSaveSlidingStep: (Int) -> Void
    
    var body: some View {
        TabView(selection: $currentStep) {
            ForEach(media.indices, id: \.self) { index in
                let object = media[index]
                ImagePlayer(url: object.url)
                    .tag(index)
                    .onTapGesture { onTapSlider(index) }
            }
            .ignoresSafeArea()
            .onDisappear { onSaveSlidingStep(currentStep) }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}
