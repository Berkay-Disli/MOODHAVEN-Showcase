//
//  HapticManager.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 25.03.2023.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static let instance = HapticManager() // Singleton
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
    func imitateHeartbeat() {
        impact(style: .light)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.impact(style: .medium)
        }
    }
    
}
