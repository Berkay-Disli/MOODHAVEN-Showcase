//
//  BackgroundMusic.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 4.04.2023.
//

import Foundation

enum BackgroundMusic: String, CaseIterable {
    case moodhaven
    case alternate
    case rain
    //case music4
    
    var icon: String {
        switch self {
        case .moodhaven:
            return "m.circle"
        case .alternate:
            return "figure.yoga"
        case .rain:
            return "cloud.bolt.rain"
        }
    }
    
    var bgImage: String {
        switch self {
        case .moodhaven:
            return "meditatingGirl4"
        case .alternate:
            return "spaceGirl2"
        case .rain:
            return "umbrella2"
        }
    }
}
