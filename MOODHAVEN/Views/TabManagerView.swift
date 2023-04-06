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
        let fgColor = navVM.appColorPreset.colorSet.fgColor
        let bgColor = navVM.appColorPreset.colorSet.bgColor
        
        /*
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
         */
        
        ZStack(alignment: .bottom) {
            switch navVM.tabSelection {
            case .home:
                HomeView(fgColor: fgColor, bgColor: bgColor)
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.25)))
            case .meditate:
                MeditateView(fgColor: fgColor, bgColor: bgColor)
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.25)))
            case .breathe:
                BreatheView(fgColor: fgColor, bgColor: bgColor)
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.25)))
            case .profile:
                ProfileView(fgColor: fgColor, bgColor: bgColor)
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.25)))
            }
            
            
            if navVM.tabBarIsShown {
                VStack(spacing: 0) {
                    Divider()
                    HStack(alignment: .bottom) {
                        ForEach(NavigationTabs.allCases, id:\.self) { tabItem in
                            Spacer()
                            VStack(spacing: 4) {
                                Image(systemName: navVM.tabSelection == tabItem ? "\(tabItem.iconName).fill" :tabItem.iconName)
                                    .font(.system(size: 20))
                                    
                                Text(tabItem.title)
                                    .font(.system(size: 11))
                            }
                            .padding(.vertical, 4)
                            .foregroundColor(navVM.tabSelection == tabItem ? fgColor: Color(uiColor: .lightGray))
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    navVM.changeTab(tabItem)
                                }
                            }
                            Spacer()
                        }
                    }
                    .padding(.top, 4)
                    .frame(height: 80, alignment: .top)
                    .background(bgColor)
                }
                .zIndex(1)
                .transition(AnyTransition.scale.combined(with: AnyTransition.opacity).animation(.easeInOut(duration: 0.25)))
                
            }
        }
        .tint(navVM.appColorPreset.colorSet.fgColor)
        .edgesIgnoringSafeArea(.bottom)

    }
}

struct TabManagerView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationViewModel())
    }
}
