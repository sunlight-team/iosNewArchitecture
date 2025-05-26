//
//  Skeleton.swift
//  UICSunlight
//
//  Created by lorenc_D_K on 20.03.2025.
//

import SwiftUI

/// Skeleton component v1.1.0
public struct Skeleton: View {
    // MARK: - Nested types
    
    public enum Mode: String, CaseIterable {
        case light
        case dark
    }
    
    /// needs to separate appearance of Skeletone in case of using as independent view
    ///  and case using as mask in func skeletoned(condition:, mode:)
    enum Kind {
        case view
        case mask
    }
    
    // MARK: - Parameters
    
    @State private var isInitialState = true
    private let mode: Mode
    private let kind: Kind
    
    private var min: CGFloat { 0 - Constant.bandSize }
    
    private var max: CGFloat { 1 + Constant.bandSize }
    
    private var opacity: CGFloat {
        switch kind {
        case .view:
            0.3
        case .mask:
            1
        }
    }
    
    private var gradient: Gradient {
        switch mode {
        case .light:
            Gradient(stops: [
                Gradient.Stop(color: .black.opacity(0.1), location: 0.00),
                Gradient.Stop(color: .black.opacity(0.15), location: 0.2),
                Gradient.Stop(color: .black.opacity(0.3), location: 0.5),
                Gradient.Stop(color: .black.opacity(0.15), location: 0.80),
                Gradient.Stop(color: .black.opacity(0.1), location: 1),
            ])
        case .dark:
            Gradient(stops: [
                Gradient.Stop(color: .black.opacity(0.1), location: 0.00),
                Gradient.Stop(color: .black.opacity(0.3), location: 0.3),
                Gradient.Stop(color: .black.opacity(0.5), location: 0.5),
                Gradient.Stop(color: .black.opacity(0.3), location: 0.70),
                Gradient.Stop(color: .black.opacity(0.1), location: 1),
            ])
        }
    }
    
    private var animation: Animation {
        .easeIn(duration: Constant.duration)
        .delay(Constant.delay)
        .repeatForever(autoreverses: false)
    }
    
    private var startPoint: UnitPoint {
        isInitialState ? UnitPoint(x: min, y: 0.5) : UnitPoint(x: 1, y: 0.5)
    }
    
    private var endPoint: UnitPoint {
        isInitialState ? UnitPoint(x: 0, y: 0.5) : UnitPoint(x: max, y: 0.5)
    }
    
    public init(mode: Mode = .light) {
        self.mode = mode
        kind = .view
    }
    
    // only for using in func skeletoned(condition:, mode:)
    init(mode: Skeleton.Mode, kind: Kind) {
        self.mode = mode
        self.kind = kind
    }
    
    public var body: some View {
        LinearGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint)
            .opacity(opacity)
            .animation(animation, value: isInitialState)
            .onAppear { isInitialState = false }
    }
}

extension Skeleton {
    private enum Constant {
        static let bandSize = 1.0
        static let duration = 1.0
        static let delay = 0.01
    }
}
