//
//  AlignmentExtensions.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import Foundation
import SwiftUI

extension View {
    func hAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    func vAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}
