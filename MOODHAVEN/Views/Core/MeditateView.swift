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
    
    let models: [MeditationModel] = [.init(id: "guided1", title: "Set Your Intention", description: "Get inspired and create the most epic day ahead.", duration: 432, audioFileName: "Set-Your-Intention", author: "Allie - The Journey Junkie", category: nil, image: "setYourIntention"),
                                     .init(id: "guided2", title: "Positive Body", description: "Accept who we are through positive body talk, self-love and acceptance.", duration: 695, audioFileName: "Positive-Body", author: "Allie - The Journey Junkie", category: nil, image: "positiveBody"),
                                     .init(id: "guided3", title: "Find Your Passion", description: "A guided meditation to dig deep, discover you and ignite your passions.", duration: 457, audioFileName: "Find-Your-Passion", author: "Allie - The Journey Junkie", category: nil, image: "findYourPassion"),
                                     .init(id: "guided4", title: "Transformation", description: "Start or strengthen the process of your transformation.", duration: 499, audioFileName: "Transformation", author: "Allie - The Journey Junkie", category: nil, image: "transformation"),
                                     .init(id: "guided5", title: "Simple yet Effective", description: "A simple yet effective exercise to manifest success and magic in your life.", duration: 440, audioFileName: "Simple-Meditation", author: "Allie - The Journey Junkie", category: nil, image: "simple"),
    ]
    
    @State private var breathingState = BreathingState.hold
    
    @State private var showAllItemsSheet = false
    @State private var progress: CGFloat = 35.0
    
    // Show tutorial sheet
    @State private var showTutorialSheet = false
    #warning("temporarily debug")
    @State private var tutorialSheetIsShown = true
    
    @State private var showGuidedMeditationActionView = false
    
    
    // Show affirmation cards
    @State private var showAffirmationCardsView = false
    @State private var guidedMeditationToShow: MeditationModel? = nil

    
    let ambientRows = [GridItem(.fixed(90), spacing: 8), GridItem(.fixed(90))]
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                ScrollViewReader { mainProxy in
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 24) {
                            
                            GreetingHeaderTextView(text: "Meditate")
                                .padding(.top, 24)
                            
                            
                            
                            
                            // MARK: Featured
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 16) {
                                    ForEach(models) { item in
                                        //RoundedRectangle(cornerRadius: 10).fill(fgColor.opacity(0.2).gradient)
                                        Button {
                                            guidedMeditationToShow = item
                                        } label: {
                                            Image(item.image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 260, height: 380)
                                                .cornerRadius(10)
                                                .overlay(content: {
                                                    RoundedRectangle(cornerRadius: 10).stroke(fgColor, lineWidth: 0.1)
                                                        .padding(1)
                                                })
                                                .overlay(alignment: .bottomLeading, content: {
                                                    VStack(alignment: .leading, spacing: 2) {
                                                        Text(item.title)
                                                            .font(.system(size: 15))
                                                            .fontWeight(.bold)
                                                        
                                                        Text(item.description)
                                                            .font(.system(size: 11))
                                                            .padding(.bottom, 6)
                                                            .multilineTextAlignment(.leading)

                                                        Text("\(giveMinutesString(duration:item.duration)) min.")
                                                            .italic()
                                                            .font(.system(size: 10))

                                                        
                                                    }
                                                    .padding(12)
                                                    .cornerRadius(10)
                                                    
                                                })
                                                .fullScreenCover(item: $guidedMeditationToShow, onDismiss: didDismiss, content: { model in
                                                    GuidedMeditationActionView(model: model, fgColor: fgColor, bgColor: bgColor)
                                                })
                                            // Shadows are optional!
                                                .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 5)
                                        }
                                        

                                             
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
                                    ForEach(BackgroundMusic.allCases, id:\.self) { item in
                                        //RoundedRectangle(cornerRadius: 6).fill(fgColor.opacity(0.2).gradient)
                                        Image(item.bgImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(height: 90)
                                            .cornerRadius(6)
                                            .overlay(content: {
                                                RoundedRectangle(cornerRadius: 6).stroke(fgColor, lineWidth: item == .moodhaven ? 0.5 : 0.1)
                                            })
                                            .overlay {
                                                Text(item.rawValue.capitalized)
                                                    .fontWeight(.semibold)
                                                    .font(.system(size: 14))
                                            }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            // MARK: Affirmation Cards
                            VStack {
                                HStack {
                                    SectionTitleView(title: "Affirmation", fgColor: fgColor)
                                    
                                    Button {
                                        // enable sheet
                                        showAffirmationCardsView.toggle()
                                    } label: {
                                        HStack {
                                            Text("All")
                                            Image(systemName: "chevron.right")
                                        }
                                        .font(.system(size: 15))
                                        .padding(.leading, 35).padding(.vertical, 3)
                                    }
                                    // Sheet page is here.
                                    .fullScreenCover(isPresented: $showAffirmationCardsView) {
                                        AffirmationCardsView(fgColor: fgColor, bgColor: bgColor)
                                    }
                                }

                                Button {
                                    showAffirmationCardsView.toggle()
                                } label: {
                                    Image("affirmationCardBg")
                                        .resizable()
                                        .frame(height: 170)
                                        .blendMode(.colorDodge) //.colorDodge > .hardLight
                                        .cornerRadius(6)
                                        .overlay(content: {
                                            RoundedRectangle(cornerRadius: 6).stroke(fgColor, lineWidth: 0.1)
                                                .padding(1)
                                        })
                                        .overlay {
                                            
                                            HStack {
                                                Text("I am surrounded by love and choose to let it fill my heart every day.")
                                                    .fontWeight(.semibold)
                                                    
                                                
                                                Spacer()
                                                Image("lineArtHeart")
                                                    .resizable()
                                                    .colorInvert()
                                                    .aspectRatio(contentMode: .fit)
                                                    .contrast(100)
                                                    .scaleEffect(1.1)
                                                    
                                                    
                                            }
                                            .padding()
                                            .hAlign(.center)
                                            .vAlign(.center)
                                            .backgroundBlur(radius: 1) // Optional?
                                             
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
                                    ForEach(models.suffix(3)) { item in
                                        RowCardView(fgColor: fgColor, title: item.title, description: item.description, isBreatheData: false, image: item.image)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            
                            
                            
                            // MARK: Spotify
                            VStack {
                                SectionTitleView(title: "Musics", fgColor: fgColor)
                                    .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(spacing: 8) {
                                        ForEach(SpotifyPlaylists.allCases, id:\.self) { item in
                                            SmallHMusicCardView(fgColor: fgColor, model: item)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            
                            
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
    
    func giveMinutesString(duration: TimeInterval) -> String {
        let date = Date()

        let cal = Calendar(identifier: .gregorian)
        let start = cal.startOfDay(for: date)
        let newDate = start.addingTimeInterval(duration)
        let formatter = DateFormatter()

        formatter.dateFormat = "mm:ss"

        let resultString = formatter.string(from: newDate)
        
        return resultString
    }
    
    func didDismiss() {
        //guidedMeditationToShow = nil
    }
    
}

struct MeditateView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationViewModel())
    }
}


// MARK: Glassmorphism


class UIBackdropView: UIView {
    override class var layerClass: AnyClass {
        NSClassFromString("CABackdropLayer") ?? CALayer.self
    }
}

struct Backdrop: UIViewRepresentable {
    func makeUIView(context: Context) -> UIBackdropView {
        UIBackdropView()
    }
    
    func updateUIView(_ uiView: UIBackdropView, context: Context) {}
}

extension View {
    func backgroundBlur(radius: CGFloat) -> some View {
        self
            .background(
            Blur(radius: radius)
            )
    }
}

struct Blur: View {
    let radius: CGFloat
    var body: some View {
        Backdrop()
            .blur(radius: radius, opaque: true)
    }
}
