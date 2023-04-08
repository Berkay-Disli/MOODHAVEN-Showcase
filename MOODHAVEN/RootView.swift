//
//  RootView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import SwiftUI
import AVFoundation

struct RootView: View {
    //@EnvironmentObject var navVM: NavigationViewModel
    let audioPlayer = SoundPlayerManager(fileName: "ambient1")
    
    var body: some View {
        TabManagerView()
            .onAppear {
                //audioPlayer.start()
            }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationViewModel())
    }
}
