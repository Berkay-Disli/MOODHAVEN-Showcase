//
//  MeditateView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import SwiftUI

struct MeditateView: View {
    let fgColor: Color
    let bgColor: Color
    
    
    
    @State private var breathingState = BreathingState.hold
    
    @State private var showAllItemsSheet = false
    @State private var progress: CGFloat = 35.0
    
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                ScrollViewReader { mainProxy in
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 24) {
                            
                            GreetingHeaderTextView(text: "Meditate")
                                .padding(.top, 24)
                            
                            
                            // MARK: Soundscapes
                            Soundscapes(fgColor: fgColor, bgColor: bgColor)
                            
                            
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
                            .id("topView")
                            .padding(.top, -8)
                            
                            
                            
                            // MARK: Recommendations
                            VStack {
                                HStack {
                                    SectionTitleView(title: "Recommended", fgColor: fgColor)
                                    
                                    Button {
                                        // enable sheet
                                        showAllItemsSheet.toggle()
                                    } label: {
                                        HStack {
                                            Text("All")
                                            Image(systemName: "chevron.right")
                                        }
                                        .font(.system(size: 15))
                                        .padding(.leading, 35).padding(.vertical, 3)
                                    }
                                    // Sheet page is here.
                                    .sheet(isPresented: $showAllItemsSheet) {
                                        VStack {
                                            Text("All models here")
                                                .font(.title2)
                                        }
                                        .vAlign(.center).hAlign(.center)
                                        
                                        .presentationDetents([.height(200), .medium])
                                        .preferredColorScheme(.dark)
                                    }
                                }
                                
                                VStack(spacing: 8) {
                                    ForEach(1...3, id:\.self) { item in
                                        RowCardView(fgColor: fgColor, title: "Colorful Day", description: "Kickstart your day with a calm and sharp mind.", isBreatheData: false)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                    
                            // MARK: Quote
                            QuoteTextView(quote: "If you change the way you look at things, the things you look at change. -*Wayne Dyer*", fgColor: fgColor)
                                
                            
                            
                            
                            
                            
                            
                            // MARK: Progress
                            LineerGaugeView(progress: progress, gaugeTitle: "Daily progress", minValue: 0, maxValue: 100)
                            
                            
                            
                            ScrollUpButton(mainProxy: mainProxy)
                        }
                        
                    }
                    .background(bgColor)
                    
                }
                
                // MARK: Zstack Toolbar Menu
                Menu {
                    Button {
                        
                    } label: {
                        Label("Background sound", systemImage: "speaker.wave.3")
                    }
                    
                    Button {
                        
                    } label: {
                        Label("Guide", systemImage: "info.circle")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .padding()
                }
                .frame(height: 80, alignment: .bottom)
                .hAlign(.trailing)
                .background {
                    Rectangle().fill(LinearGradient(colors: [bgColor, bgColor, .clear], startPoint: .top, endPoint: .bottom))
                }
                .edgesIgnoringSafeArea(.top)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
}

struct MeditateView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationViewModel())
    }
}
