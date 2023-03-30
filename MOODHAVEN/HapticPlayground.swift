//
//  HapticPlayground.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 30.03.2023.
//

import SwiftUI

struct HapticPlayground: View {
    
    /// Use haptics everywhere. Tab selections, buttons and all
    var body: some View {
        VStack(spacing: 20) {
            
            Button("success") { HapticManager.instance.notification(type: .success) }
            Button("warning") { HapticManager.instance.notification(type: .warning) }
            Button("error") { HapticManager.instance.notification(type: .error) }
            Divider()
            Button("soft") { HapticManager.instance.impact(style: .soft) }
            Button("light") { HapticManager.instance.impact(style: .light) }
            Button("medium") { HapticManager.instance.impact(style: .medium) }
            Button("rigid") { HapticManager.instance.impact(style: .rigid) }
            Button("heavy") { HapticManager.instance.impact(style: .heavy) }
        }
    }
}

struct HapticPlayground_Previews: PreviewProvider {
    static var previews: some View {
        HapticPlayground()
    }
}
