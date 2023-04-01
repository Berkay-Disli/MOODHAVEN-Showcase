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
        impact(style: .medium)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.impact(style: .light)
        }
    }
    
}
/*
0 bam
0.4 bam

1.4 bam
1.8 bam

2.8 bam
3.2 bam

4.2 bam
4.6 bam
*/
