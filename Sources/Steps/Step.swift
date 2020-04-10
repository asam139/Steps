//
//  Step.swift
//  
//
//  Created by Saul Moreno Abril on 10/04/2020.
//

import SwiftUI

public struct Step: Identifiable {
    public var id = UUID()
    public var title: String?
    public var image: Image?

    public init(title: String? = nil, image: Image? = nil) {
        self.title = title
        self.image = image
    }
}
