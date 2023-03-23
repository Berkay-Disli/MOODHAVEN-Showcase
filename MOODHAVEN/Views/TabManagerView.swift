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
                    Label("Sent", systemImage: "sun.haze")
                }
                .tag(NavigationTabs.meditate)

            BreatheView()
                .tabItem {
                    Label("Account", systemImage: "waveform.path") //.ecg
                }
                .tag(NavigationTabs.breathe)
            ProfileView()
                //.badge(1)
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
                .tag(NavigationTabs.profile)
        }
        .tint(navVM.appColorPreset.colorSet.fgColor)
        //.background(navVM.appColorPreset.colorSet.bgColor)
    }
}

struct TabManagerView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationViewModel())
    }
}
