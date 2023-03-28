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
    @State private var customInhaleTime = 7
    @State private var customHoldTime = 7
    @State private var customExhaleTime = 7
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
                                RoundedRectangle(cornerRadius: 10).fill(fgColor.opacity(0.2).gradient)
                                    .frame(width: 260, height: 380)
                                    .overlay(content: {
                                        RoundedRectangle(cornerRadius: 10).stroke(fgColor, lineWidth: 0.1)
                                    })
                                // Shadows are optional!
                                    .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 5)
                            }
                        }
                        .padding(.horizontal)
                    }
                    Text("Featured")
                        .font(.system(size: 11))
                        .foregroundColor(fgColor)
                        .padding(.top, -10)
                    
                    // MARK: Recommendations Depending on the time!!
                    VStack {
                        HStack {
                            SectionTitleView(title: "Exercises for this evening", fgColor: fgColor)
                            
                            Button {
                                // enable sheet
                            } label: {
                                HStack {
                                    Text("All")
                                    Image(systemName: "chevron.right")
                                }
                                .font(.system(size: 15))
                                .padding(.leading, 35).padding(.vertical, 3)
                            }
                        }
                        
                        VStack(spacing: 8) {
                            ForEach(1...3, id:\.self) { item in
                                RowCardView(fgColor: fgColor, title: "4-7-8 Breathing", description: "Calm your mind by slowing down your breathing.")
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // MARK: Are you uneasy?
                    VStack {
                        SectionTitleView(title: "Stop feeling anxious", fgColor: fgColor)
                            .padding(.leading)
                        
                        TabView {
                            ForEach(1...3, id:\.self) { item in
                                RoundedRectangle(cornerRadius: 8).fill(fgColor.opacity(0.2).gradient)
                                    .frame(height: 125)
                                    .padding(.horizontal)
                            }
                        }
                        .frame(height: 130)
                        .tabViewStyle(.page(indexDisplayMode: .always))
                    }
                    
                    // MARK: Quote
                    QuoteTextView(quote: "Mindfulness meditation is the embrace of any and all mind states in awareness, without preferring one to another. -*Jon Kabat-Zinn*", fgColor: fgColor)
                    
                    // MARK: Custom Meditation
                    VStack(spacing: 6) {
                        HStack {
                            SectionTitleView(title: "Create your own", fgColor: fgColor)
                            
                            Button {
                                // enable sheet
                            } label: {
                                HStack {
                                    Text("Start")
                                    Image(systemName: "chevron.right")
                                }
                                .font(.system(size: 15))
                                .padding(.leading, 35).padding(.vertical, 3)
                            }
                        }
                        
                        HStack {
                            VStack {
                                Picker("Inhale time", selection: $customInhaleTime) {
                                    ForEach(2...12, id: \.self) { number in
                                        Text("\(number)")
                                    }
                                }
                                .frame(height: 150)
                                .pickerStyle(.inline)
                                
                                Text("Inhale Time")

                            }
                            
                            VStack {
                                Picker("Hold time", selection: $customHoldTime) {
                                    ForEach(2...12, id: \.self) { number in
                                        Text("\(number)")
                                    }
                                }
                                .frame(height: 150)
                                .pickerStyle(.inline)
                                
                                Text("Hold Time")
                            }
                            
                            VStack {
                                Picker("Exhale time", selection: $customExhaleTime) {
                                    ForEach(2...12, id: \.self) { number in
                                        Text("\(number)")
                                    }
                                }
                                .frame(height: 150)
                                .pickerStyle(.inline)
                                
                                Text("Exhale Time")
                            }
                        }
                        .font(.system(size: 12))
                        .foregroundColor(fgColor)
                    }
                    .padding(.horizontal)
                    
                    .padding(.bottom, 40)
                    
                    
                }
            }
            .background(bgColor)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct BreatheView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationViewModel())
    }
}
