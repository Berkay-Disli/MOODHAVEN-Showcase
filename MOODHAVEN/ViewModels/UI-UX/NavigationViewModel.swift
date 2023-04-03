//
//  NavigationViewModel.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import Foundation

class NavigationViewModel: ObservableObject {
    @Published var appColorPreset: AppThemeColorPresets = .preset8
    @Published var tabSelection: NavigationTabs = .meditate
    @Published var tabBarIsShown = true
    
    func changeColorPreset(colorPreset: AppThemeColorPresets) {
        appColorPreset = colorPreset
    }
    
    func changeTab(_ tab: NavigationTabs) {
        tabSelection = tab
    }
    
    // These two functions are for making the tab bar visible/invisible
        func enableTabBar() {
            tabBarIsShown = true
        }
        func disableTabBar() {
            tabBarIsShown = false
        }
    
}
