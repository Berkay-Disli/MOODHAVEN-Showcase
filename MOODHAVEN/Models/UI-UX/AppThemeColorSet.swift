//
//  AppThemeColorSet.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import Foundation
import SwiftUI

struct AppThemeColorSet {
    let fgColor: Color
    let bgColor: Color
}

enum AppThemeColorPresets {
    case preset0, preset1, preset2, preset3, preset5
    case preset6, preset7, preset8, preset9, preset10
    
    var colorSet: AppThemeColorSet {
        switch self {
        case .preset0:
            return .init(fgColor: .fg0, bgColor: .set0)
        case .preset1:
            return .init(fgColor: .fg1, bgColor: .set1)
        case .preset2:
            return .init(fgColor: .fg2, bgColor: .set2)
        case .preset3:
            return .init(fgColor: .fg3, bgColor: .set3)

        case .preset5:
            return .init(fgColor: .fg5, bgColor: .set5)
        case .preset6:
            return .init(fgColor: .fg6, bgColor: .set6)
        case .preset7:
            return .init(fgColor: .fg7, bgColor: .set7)
        case .preset8:
            return .init(fgColor: .fg8, bgColor: .set8)
        case .preset9:
            return .init(fgColor: .fg9, bgColor: .set9)
        case .preset10:
            return .init(fgColor: .fg10, bgColor: .set10)
        }
    }
}
