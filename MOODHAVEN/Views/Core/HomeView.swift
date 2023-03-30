//
//  HomeView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var navVM: NavigationViewModel
    
    @State private var progress = 0.0
    @State private var soundscapeAnimationCompleted = false
    
    let hour = Calendar.current.component(.hour, from: Date())
    
    
    var body: some View {
        let fgColor = navVM.appColorPreset.colorSet.fgColor
        let bgColor = navVM.appColorPreset.colorSet.bgColor
        
        NavigationView {
            ZStack(alignment: .topTrailing) {
                ScrollViewReader { mainProxy in
                    ScrollView(showsIndicators: false, content: {
                        LazyVStack(spacing: 24) {
                            // MARK: Header with progress gauge
                            VStack(spacing: 16) {
                                //GreetingHeaderTextView(text: "Namaste!")
                                // MARK: Depending on the time of day!
                                if 17 <= hour && hour <= 21 {
                                    GreetingHeaderTextView(text: "Good evening")
                                } else if 22 <= hour && hour <= 4 {
                                    GreetingHeaderTextView(text: "Good night")
                                } else if 5 <= hour && hour <= 11 {
                                    GreetingHeaderTextView(text: "Good morning")
                                } else {
                                    GreetingHeaderTextView(text: "Good afternoon")
                                }
                                
                                QuoteTextView(quote: "If you change the way you look at things, the things you look at change. -*Wayne Dyer*", fgColor: fgColor)
                                    
                                // Soundscapes
                                Soundscapes(soundscapeAnimationCompleted: $soundscapeAnimationCompleted, fgColor: fgColor)
                                
                                
                                
                                // Progress Gauge
                                Button {
                                    navVM.changeTab(.profile)
                                } label: {
                                    LineerGaugeView(progress: progress, gaugeTitle: "Daily progress", minValue: 0, maxValue: 100)
                                }
                                .onAppear {
                                    withAnimation(.easeInOut) {
                                        progress = 35.0
                                    }
                                }

                            }
                            .foregroundColor(fgColor)
                            .id("topView")
                            
                            // Big Cards
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 16) {
                                    ForEach(1...5, id:\.self) { item in
                                        RoundedRectangle(cornerRadius: 7).fill(fgColor.opacity(0.2).gradient)
                                            .frame(width: 120, height: 160)
                                            .overlay(content: {
                                                RoundedRectangle(cornerRadius: 7).stroke(fgColor, lineWidth: 0.1)
                                            })
                                        // Shadows are optional!
                                            .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 5)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            
                            // Section-1
                            VStack(alignment: .leading, spacing: 8) {
                                SectionTitleView(title: "Today's meditations", fgColor: fgColor)
                                
                                HStack(spacing: 16) {
                                    ForEach(1...2, id:\.self) { item in
                                        SmallHCardView(fgColor: fgColor, category: "Mindful Start", title: "Reflecting on Self-Compassion", duration: 12)
                                    }
                                }
                                
                            }
                            .padding(.horizontal)
                            
                            // Section-2
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("Breathing exercises")
                                    Spacer()
                                    
                                    Button {
                                        navVM.changeTab(.breathe)
                                    } label: {
                                        HStack {
                                            Text("All")
                                            
                                            Image(systemName: "chevron.right")
                                        }
                                        .font(.system(size: 15))
                                        .padding(.leading, 35).padding(.vertical, 3)
                                    }
                                }
                                .font(.system(size: 18))
                                .foregroundColor(fgColor)
                                
                                VStack(spacing: 8) {
                                    ForEach(1...3, id:\.self) { item in
                                        RowCardView(fgColor: fgColor, title: "4-7-8 Breathing", description: "Calm your mind by slowing down your breathing.")
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            // About Moodhaven
                            VStack(alignment: .leading, spacing: 16) {
                                let options: [String] = [
                                "About Moodhaven",
                                "How it works",
                                "Frequently asked questions",
                                "User guide",
                                "Follow us",
                                "Terms of use"
                                ]
                                Text("MOODHAVEN")
                                    .font(.system(size: 14))
                                    .hAlign(.leading)
                                
                                ForEach(options, id:\.self) { item in
                                    Text(item)
                                        .font(.system(size: 13))
                                        .foregroundColor(fgColor)
                                    
                                }
                            }
                            .padding(.horizontal)
                            
                            // Tap button to scroll up!
                            Button {
                                withAnimation(.easeInOut) {
                                    mainProxy.scrollTo("topView", anchor: .init(x: 0, y: 1))
                                }
                            } label: {
                                Image(systemName: "arrow.up")
                                    .font(.system(size: 14))
                                    .padding()
                                    
                            }
                            .padding(.top, -20)
                            .padding(.bottom)
                            //.id("bottom")
                        }
                        .padding(.top, 24)
                    })
                    .onAppear {
                        #warning("Delete this later.")
                        // MARK: Debugging purposes only for now
                        //navVM.changeColorPreset(colorPreset: .preset8)
                        //mainProxy.scrollTo("bottom")
                    }
                    .background(bgColor)
                }
                
                
                // MARK: Zstack Toolbar Menu
                Menu {
                    Button {
                        
                    } label: {
                        Label("Options will be here", systemImage: "gearshape")
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
            .toolbar(.hidden, for: .navigationBar)
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
