//
//  LoadingState.swift
//  SunlightArchitectureIOS
//
//  Created by lorenc_D_K on 05.05.2025.
//

import Foundation

public enum LoadingState: Equatable {
    case none
    case loading
    case loadError(error: String)
    case hide
}
