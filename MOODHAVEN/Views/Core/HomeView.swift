//
//  HomeView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var navVM: NavigationViewModel
    
    var body: some View {
        // preset4 is gone for now.
        // preset1, preset5 and preset10 are alike.
        let colorSet = navVM.appColorPreset.colorSet
        NavigationView {
            VStack(spacing: 10) {
                Text("Welcome to **MOODHAVEN**")
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .lineLimit(2)
                    .hAlign(.leading)
                    .padding(.top)
                
                Spacer()
                
                Text("Welcome Home")
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .foregroundColor(colorSet.fgColor)
                
                Text("This is MOODHAVEN")
                    .font(.largeTitle)
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                
                Spacer()
                    
            }
            .padding(.horizontal)
            .onAppear {
                // MARK: Debugging purposes only for now
                navVM.changeColorPreset(colorPreset: .preset1)
            }
            .vAlign(.center)
            .hAlign(.center)
            .background(colorSet.bgColor)
            
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationViewModel())
    }
}
