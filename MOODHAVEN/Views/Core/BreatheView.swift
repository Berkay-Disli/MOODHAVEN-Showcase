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
    
    let fgColor: Color
    let bgColor: Color
    
    @State private var customInhaleTime = 7
    @State private var customHoldTime = 7
    @State private var customExhaleTime = 7
    
    @State private var progress = 70.0
    
    @State private var showBreathActionScreenCover = false
    
    // Not used yet
    @State private var showAllItemsSheet = false
    
    // Show tutorial sheet
    @State private var showTutorialSheet = false
    #warning("temporarily debug")
    @State private var tutorialSheetIsShown = true
    
    // MARK: Data to show in fullscreenCover
    var breatheModel: BreathingModel?
    
    // Different items
    let hour = Calendar.current.component(.hour, from: Date())

    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                ScrollViewReader { mainProxy in
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
                                            .frame(width: 320, height: 230)
                                            .overlay(content: {
                                                RoundedRectangle(cornerRadius: 10).stroke(fgColor, lineWidth: 0.1)
                                            })
                                        // Shadows are optional!
                                            .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 5)
                                            .onTapGesture {
                                                self.showBreathActionScreenCover.toggle()
                                                //self.breatheModel = item
                                                HapticManager.instance.impact(style: .soft)
                                            }
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .id("topView")
                            
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
                                        showAllItemsSheet.toggle()
                                    } label: {
                                        HStack {
                                            Text("All")
                                            Image(systemName: "chevron.right")
                                        }
                                        .font(.system(size: 15))
                                        .padding(.leading, 35).padding(.vertical, 3)
                                    }
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
                                        RowCardView(fgColor: fgColor, title: "4-7-8 Breathing", description: "Calm your mind by slowing down your breathing.", isBreatheData: true)
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
                            QuoteTextView(quote: "'Mindfulness meditation is the embrace of any and all mind states in awareness, without preferring one to another.' -*Jon Kabat Zinn*", fgColor: fgColor)
                            
                            // MARK: Custom Meditation
                            VStack(spacing: 6) {
                                HStack {
                                    SectionTitleView(title: "Create your own", fgColor: fgColor)
                                    
                                    NavigationLink {
                                        BreatheActionView(breathingModel: BreathingModel(title: "", description: "", duration: 3, steps: [], note: nil, inhaleTime: customInhaleTime, holdTime: customHoldTime, exhaleTime: customExhaleTime))
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
                            
                            // MARK: Add stats to link to profile
                            
                            LineerGaugeView(progress: progress, gaugeTitle: progress >= 50 ? "You're doing good today":"Today's progress", minValue: 0, maxValue: 100)
                            
                            
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
                            .padding(.bottom, 55)

                        }
                    }
                    .background(bgColor)
                    //enable tutorial sheet on appear
                    .onAppear {
                        #warning("doesnt work because of custom tabview.")
                        #warning("USE USERDEFAULTS")
                        if !tutorialSheetIsShown {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.tutorialSheetIsShown = true
                                showTutorialSheet.toggle()
                            }
                            
                        }
                    }
                }
                
                // MARK: Zstack Toolbar Menu
                Menu {
                    Button {
                        
                    } label: {
                        Label("Background sound", systemImage: "speaker.wave.3")
                    }
                    
                    Button {
                        showTutorialSheet.toggle()
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
            .fullScreenCover(isPresented: $showTutorialSheet) {
                BreatheTutorialMainView(fgColor: fgColor, bgColor: bgColor)
            }
            .fullScreenCover(isPresented: $showBreathActionScreenCover) {
                BreatheInfoView(colorPreset: navVM.appColorPreset, breathingModel: breatheModel ?? BreathingModel(title: "4-7-8 Breathing",
                                                                                                  description: "This breathing exercise helps to calm the mind and reduce anxiety. It involves breathing in for 4 seconds, holding the breath for 7 seconds, and exhaling for 8 seconds.",
                                                                                                  duration: 2,
                                                                                                  steps: ["Find a comfortable seated position with your back straight and your hands resting on your thighs or in your lap.",
                                                                                                          "Close your eyes and take a few deep breaths to relax your body.",
                                                                                                          "Now, inhale deeply through your nose for 4 seconds.",
                                                                                                          "Hold your breath for 7 seconds.",
                                                                                                          "Exhale slowly through your mouth for 8 seconds.",
                                                                                                          "Repeat this breathing pattern for several more cycles.",
                                                                                                          "As you breathe, focus on the sensation of the air moving in and out of your body.",
                                                                                                          "If your mind wanders, gently bring your attention back to your breath.",
                                                                                                          "Continue this breathing pattern for the duration of the exercise.",
                                                                                                          "When you are ready to finish, take a few deep breaths and slowly open your eyes."],
                                                                                                  note: "This exercise can be practiced for as long as you like. It's a simple yet powerful way to bring calm and relaxation into your day.",
                                                                                                  inhaleTime: 4, holdTime: 7, exhaleTime: 8))
            }
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
