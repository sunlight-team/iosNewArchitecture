//
//  LayeredImage.swift
//  SunlightArchitectureIOS
//
//  Created by lorenc_D_K on 05.05.2025.
//

import UIKit

struct NetworkImage: Identifiable {
    let id = UUID()
    let url: URL?
    
    init(url: URL?) {
        self.url = url
    }
}
