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
    
    let models: [MeditationModel] = [.init(id: "guided1", title: "Find Your Passion", description: "A guided meditation to dig deep, discover you and ignite your passions.", duration: "7:37", audioFileName: "Find-Your-Passion", author: "Allie - The Journey Junkie", category: nil, imageUrl: nil),
                                     .init(id: "guided2", title: "Positive Body", description: "Accept who we are through positive body talk, self-love and acceptance.", duration: "11:35", audioFileName: "Positive-Body", author: "Allie - The Journey Junkie", category: nil, imageUrl: nil),
                                     .init(id: "guided3", title: "Transformation", description: "Start or strengthen the process of your transformation.", duration: "8:19", audioFileName: "Transformation", author: "Allie - The Journey Junkie", category: nil, imageUrl: nil),
                                                                      .init(id: "guided4", title: "Simple yet Effective", description: "A simple yet effective exercise to manifest success and magic in your life.", duration: "7:20", audioFileName: "Simple-Meditation", author: "Allie - The Journey Junkie", category: nil, imageUrl: nil),
                                     .init(id: "guided5", title: "Set Your Intention", description: "Get inspired and create the most epic day ahead.", duration: "7:12", audioFileName: "Set-Your-Intention", author: "Allie - The Journey Junkie", category: nil, imageUrl: nil)]
    
    @State private var breathingState = BreathingState.hold
    
    @State private var showAllItemsSheet = false
    @State private var progress: CGFloat = 35.0
    
    // Show tutorial sheet
    @State private var showTutorialSheet = false
    #warning("temporarily debug")
    @State private var tutorialSheetIsShown = true
    
    let ambientRows = [GridItem(.fixed(90), spacing: 8), GridItem(.fixed(90))]
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                ScrollViewReader { mainProxy in
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 24) {
                            
                            GreetingHeaderTextView(text: "Meditate")
                                .padding(.top, 24)
                            
                            /*
                            // MARK: Soundscapes
                            Soundscapes(fgColor: fgColor, bgColor: bgColor)
                            */
                            
                            // MARK: Featured
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 16) {
                                    ForEach(models) { item in
                                        RoundedRectangle(cornerRadius: 10).fill(fgColor.opacity(0.2).gradient)
                                            .frame(width: 260, height: 380)
                                            .overlay(content: {
                                                RoundedRectangle(cornerRadius: 10).stroke(fgColor, lineWidth: 0.1)
                                            })
                                            .overlay(alignment: .bottomLeading, content: {
                                                VStack(alignment: .leading, spacing: 4) {
                                                    Text(item.title)
                                                        .font(.system(size: 15))
                                                    
                                                    Text(item.description)
                                                        .font(.system(size: 12))
                                                        .lineSpacing(4)
                                                        .padding(.bottom)

                                                    Text(item.duration)
                                                        .font(.system(size: 11))

                                                    
                                                }
                                                .padding(12)
                                            })
                                        // Shadows are optional!
                                            .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 5)
                                             
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .id("topView")
                            .padding(.top, -8)
                            
                            // MARK: Ambient
                            VStack {
                                SectionTitleView(title: "Ambient", fgColor: fgColor)
                                
                                HStack(spacing: 12) {
                                    ForEach(0..<3) { item in
                                        RoundedRectangle(cornerRadius: 6).fill(fgColor.opacity(0.2).gradient)
                                            .frame(height: 90)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            
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
                MeditateTutorialMainView(fgColor: fgColor, bgColor: bgColor)
                    
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
