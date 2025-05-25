//
//  LayeredImagePlayer 2.swift
//  SunlightArchitectureIOS
//
//  Created by lorenc_D_K on 05.05.2025.
//


import SwiftUI

struct ImagePlayer: View {
    let url: URL?
    
    var body: some View {
        AsyncImage(url: url) { result in
            if let image = result.image {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                Skeleton()
            }
        }
    }
}
