//
//  Spinner.swift
//  SunlightNewArchitectureIOS
//
//  Created by lorenc_D_K on 14.05.2025.
//

import SwiftUI


struct Spinner: View {
    
    // MARK: - Private Properties
    
    @State private var rotationAngle: Angle = .degrees(0)
    @State private var progressEnd: CGFloat = 1
    @State private var progressStart: CGFloat = 0
    
    private var lineWidth: CGFloat
    
    // MARK: - Init
    
    init(lineWidth: CGFloat = 2) {
        self.lineWidth = lineWidth
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.white, lineWidth: lineWidth)
            
            Circle()
                .trim(from: progressStart, to: progressEnd)
                .stroke(
                    Color.spinnerTint,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(rotationAngle)
        }
        .frame(width: 24, height: 24)
        .onAppear {
            startAnimation()
        }
    }
}

// MARK: - Private Methods

extension Spinner {
    private func startAnimation() {
        withAnimation(.linear(duration: 4.0).repeatForever(autoreverses: false)) {
            rotationAngle = .degrees(360)
        }
        
        withAnimation(.easeInOut(duration: 1.0)) {
            progressStart = 0
            progressEnd = 1
        }
        
        withAnimation(.easeInOut(duration: 2.0).delay(1)) {
            progressStart = 1.05
        }
        
        Task { @MainActor in
            try? await Task.sleep(nanoseconds: UInt64(3 * Double(NSEC_PER_SEC)))
            progressStart = 0
            progressEnd = 0
            startAnimation()
        }
    }
}
