//
//  NavigationViewModel.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import Foundation

class NavigationViewModel: ObservableObject {
    @Published var appColorPreset: AppThemeColorPresets = .preset6
    @Published var tabSelection: NavigationTabs = .home
    
    
    func changeColorPreset(colorPreset: AppThemeColorPresets) {
        appColorPreset = colorPreset
    }
    
    func changeTab(_ tab: NavigationTabs) {
        tabSelection = tab
    }
    
}
