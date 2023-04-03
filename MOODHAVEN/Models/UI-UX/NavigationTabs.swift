//
//  NavigationTabs.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import Foundation

enum NavigationTabs: String, CaseIterable {
    case home, meditate, breathe, profile
    
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .meditate:
            return "Meditate"
        case .breathe:
            return "Breathe"
        case .profile:
            return "Profile"
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .meditate:
            return "sun.haze"
        case .breathe:
            return "lungs"
        case .profile:
            return "person"
        }
    }
    
}
