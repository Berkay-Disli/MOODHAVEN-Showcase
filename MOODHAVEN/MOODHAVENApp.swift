//
//  MOODHAVENApp.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import SwiftUI

@main
struct MOODHAVENApp: App {
    var body: some Scene {
        WindowGroup {
            
            RootView()
                .preferredColorScheme(.dark)
                .environmentObject(NavigationViewModel())
            
            
            /*
            HapticPlayground()
                .preferredColorScheme(.dark)
             */
        }
    }
}
