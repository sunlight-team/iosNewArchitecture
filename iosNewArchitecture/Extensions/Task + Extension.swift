//
//  Task + Extension.swift
//  SunlightArchitectureIOS
//
//  Created by lorenc_D_K on 05.05.2025.
//

import Foundation

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * Double(NSEC_PER_SEC))
        try await Task.sleep(nanoseconds: duration)
    }
}
