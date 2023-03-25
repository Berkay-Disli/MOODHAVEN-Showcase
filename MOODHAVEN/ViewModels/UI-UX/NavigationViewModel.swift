//
//  NavigationViewModel.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import Foundation

class NavigationViewModel: ObservableObject {
    @Published var appColorPreset: AppThemeColorPresets = .preset9
    @Published var tabSelection: NavigationTabs = .breathe
    
    
    func changeColorPreset(colorPreset: AppThemeColorPresets) {
        appColorPreset = colorPreset
    }
    
}
