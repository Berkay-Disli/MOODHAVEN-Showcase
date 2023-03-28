//
//  TabManagerView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import SwiftUI

struct TabManagerView: View {
    @EnvironmentObject private var navVM: NavigationViewModel
    
    var body: some View {
        TabView(selection: $navVM.tabSelection) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(NavigationTabs.home)
            MeditateView()
                .tabItem {
                    Label("Meditate", systemImage: "sun.haze")
                }
                .tag(NavigationTabs.meditate)

            BreatheView()
            //BreatheActionView()
                .tabItem {
                    Label("Breathe", systemImage: "waveform.path") //.ecg
                }
                .tag(NavigationTabs.breathe)
            ProfileView()
                //.badge(1)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(NavigationTabs.profile)
        }
        .tint(navVM.appColorPreset.colorSet.fgColor)
    }
}

struct TabManagerView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationViewModel())
    }
}
