//
//  Helpers.swift
//  Steps
//
//  Created by Saul Moreno Abril on 19/04/2020.
//

import SwiftUI
import Combine

// MARK: - View Inspection helper

/// Helper to inspection in the tests
internal final class Inspection<V> where V: View {
    let notice = PassthroughSubject<UInt, Never>()
    var callbacks = [UInt: (V) -> Void]()

    func visit(_ view: V, _ line: UInt) {
        if let callback = callbacks.removeValue(forKey: line) {
            callback(view)
        }
    }
}
