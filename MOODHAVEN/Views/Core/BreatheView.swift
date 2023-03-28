//
//  BreatheView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import SwiftUI
import CoreHaptics

struct BreatheView: View {
    @EnvironmentObject private var navVM: NavigationViewModel
    
    var body: some View {
        let fgColor = navVM.appColorPreset.colorSet.fgColor
        let bgColor = navVM.appColorPreset.colorSet.bgColor
        
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 24) {
                    // MARK: Header
                    GreetingHeaderTextView(text: "Take a breath.")
                        .padding(.top, 24)
                    
                    // MARK: Featured
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 16) {
                            ForEach(1...5, id:\.self) { item in
                                RoundedRectangle(cornerRadius: 8).fill(fgColor.opacity(0.2).gradient)
                                    .frame(width: 260, height: 380)
                                    .overlay(content: {
                                        RoundedRectangle(cornerRadius: 8).stroke(fgColor, lineWidth: 0.1)
                                    })
                                // Shadows are optional!
                                    .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 5)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    
                }
            }
            .background(bgColor)
        }
    }
}

struct BreatheView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationViewModel())
    }
}
