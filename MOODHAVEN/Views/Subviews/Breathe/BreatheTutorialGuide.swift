//
//  BreatheTutorialGuide.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 3.04.2023.
//

import SwiftUI
import RiveRuntime

struct BreatheTutorialGuidePartOne: View {
    
    @Binding var pages: BreathTutorialPages
    
    let fgColor: Color
    let bgColor: Color
    
    let bird1 = RiveViewModel(fileName: "bird1")
    let bird2 = RiveViewModel(fileName: "bird2")
    let doggo = RiveViewModel(fileName: "homeViewAnimal")
    
    @State private var showAnimations = [false, false, false, false, false, false, false, true]
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 16) {
            
            if showAnimations[7] {
                GreetingHeaderTextView(text: "This is the Breathe Section")
                    .padding(.top)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            }
            
            if showAnimations[0] {
                    bird1.view()
                        .frame(width: 70, height: 70)
                        .padding(.top, 8)
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                    
            }
            
            VStack(alignment: .leading, spacing: 0) {
                
                if showAnimations[1] {
                    Text("You can practice different breathing techniques to help you relax, reduce stress, and improve your overall well-being.")
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                    
                
                
                if showAnimations[2] {
                    bird2.view()
                        .frame(width: 70, height: 70)
                        .hAlign(.trailing)
                        .padding(.bottom)
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                }
                
                
                if showAnimations[3] {
                    Text("Here, you'll find a variety of breathing exercises, each designed to help you achieve different outcomes.")
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        .padding(.horizontal)
                }
                
                
                if showAnimations[4] {
                    doggo.view()
                       .frame(height: 120)
                       .padding(.bottom)
                       .transition(AnyTransition.opacity.animation(.easeInOut))
                }
                
                
                if showAnimations[5] {
                    Text("You can customize your breathing exercises based on your personal preferences, and even create your own custom exercises.")
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        .padding(.horizontal)
                }
                    
                
                
            }
            .multilineTextAlignment(.center)
            
            
            if showAnimations[6] {
                HStack {
                    Spacer()
                    Button {
                        HapticManager.instance.impact(style: .soft)
                        hideElements()
                    } label: {
                        Text("Next")
                        
                            .foregroundColor(fgColor)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.vertical, 7)
                            .background {
                                RoundedRectangle(cornerRadius: 5).stroke(fgColor, lineWidth: 1)
                            }
                        
                    }
                    Spacer()
                }
                .padding(.top, 20)
                .transition(AnyTransition.opacity.animation(.easeInOut))
            }
            
            
            
            
            
            Spacer()
        }
        // Not sure with this one!
        .hAlign(.center).vAlign(.center)
        .font(.system(size: 14))
        .foregroundColor(fgColor)
        .lineSpacing(4)
        .padding(.vertical)
        .background(bgColor)
        .onAppear {
            showElements()
        }
        .onDisappear {
            hideElements()
            
        }
    }
    
    func showElements() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut) {
                showAnimations[0] = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation(.easeInOut) {
                showAnimations[1] = true
                
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            withAnimation(.easeInOut) {
                showAnimations[2] = true
                
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation(.easeInOut) {
                showAnimations[3] = true
                
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeInOut) {
                showAnimations[4] = true
                
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            withAnimation(.easeInOut) {
                showAnimations[5] = true
                
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
            withAnimation(.easeInOut) {
                showAnimations[6] = true
                
            }
        }
    }
    
    func hideElements() {
        for i in 0...7 {
            withAnimation(.easeInOut) {
                showAnimations[i] = false
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeInOut) {
                pages = .second
            }
        }
    }
}

struct BreatheTutorialGuidePartTwo: View {
    @Binding var pages: BreathTutorialPages

    let fgColor: Color
    let bgColor: Color
    
    @State private var customInhaleTime = 7
    @State private var customHoldTime = 7
    @State private var customExhaleTime = 7
    
    @State private var showAnimations = [false, false, false, false, false, true]
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 16) {
            
            if showAnimations[5] {
                GreetingHeaderTextView(text: "Breathing Models")
                    .padding(.top)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            }
            
            if showAnimations[0] {
                // MARK: Redacted
                VStack(spacing: 8) {
                    ForEach(1...2, id:\.self) { item in
                        RowCardView(fgColor: fgColor, title: "4-7-8 Breathing", description: "Calm your mind by slowing down your breathing.", isBreatheData: true)
                    }
                }
                .redacted(reason: .placeholder)
                .padding(.horizontal)
                .transition(AnyTransition.opacity.animation(.easeInOut))
            }
            
            VStack(alignment: .leading, spacing: 0) {
                
                if showAnimations[1] {
                    Text("You can choose from various breathing models to guide your breathing exercises, or customize the models or create your own by adjusting the inhale, hold, and exhale times.")
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        .padding()
                        .hAlign(.center)
                }
                    
                
                
                if showAnimations[2] {
                    // MARK: Redacted
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
                    .transition(AnyTransition.opacity.animation(.easeInOut))
                    .redacted(reason: .placeholder)
                }
                
                if showAnimations[3] {
                    Text("Try out different breathing models to see which one works best for you and your mood.")
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        .padding()
                        .padding(.top)
                        .hAlign(.center)
                        
                }
            }
            .multilineTextAlignment(.center)
            
            
            if showAnimations[4] {
                HStack {
                    Spacer()
                    Button {
                        HapticManager.instance.impact(style: .soft)
                        hideElements()
                    } label: {
                        Text("Next")
                        
                            .foregroundColor(fgColor)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.vertical, 7)
                            .background {
                                RoundedRectangle(cornerRadius: 5).stroke(fgColor, lineWidth: 1)
                            }
                        
                    }
                    Spacer()
                }
                .transition(AnyTransition.opacity.animation(.easeInOut))
            }
            
            
            Spacer()
        }
        // Not sure with this one!
        .hAlign(.center).vAlign(.center)
        .font(.system(size: 14))
        .foregroundColor(fgColor)
        .lineSpacing(4)
        .padding(.vertical)
        .background(bgColor)
        .onAppear {
            showElements()
        }
        .onDisappear {
            hideElements()
            
        }
        .preferredColorScheme(.dark)
    }
    
    func showElements() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut) {
                showAnimations[0] = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation(.easeInOut) {
                showAnimations[1] = true
                
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            withAnimation(.easeInOut) {
                showAnimations[2] = true
                
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation(.easeInOut) {
                showAnimations[3] = true
                
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeInOut) {
                showAnimations[4] = true
                
            }
        }
    }
    
    func hideElements() {
        for i in 0...5 {
            withAnimation(.easeInOut) {
                showAnimations[i] = false
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeInOut) {
                pages = .third
            }
        }
    }
}

struct BreatheTutorialGuidePartThree: View {
    @Binding var pages: BreathTutorialPages
    @Environment(\.dismiss) var dismiss
    
    let fgColor: Color
    let bgColor: Color
    
    @State private var breathCircle = RiveViewModel(fileName: "breathCircle-3", stateMachineName: "State Machine 1")
    
    let soundIcon = RiveViewModel(fileName: "soundIcon", animationName: "Example")
    
    @State private var showAnimations = [false, false, false, false, false, false, true]
    
    @State private var heartbeatTimer = Timer.publish(every: 1.1, on: .main, in: .common).autoconnect()

    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 16) {
            
            if showAnimations[6] {
                GreetingHeaderTextView(text: "How to Use")
                    .padding(.top)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
                    .onReceive(heartbeatTimer, perform: { _ in
                        HapticManager.instance.imitateHeartbeat()
                    })
            }
            
            VStack(alignment: .leading, spacing: 0) {
                
                if showAnimations[0] {
                    Text("Find a quiet and comfortable place to practice, where you won't be disturbed.")
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        .padding(.horizontal)
                        .padding(.bottom)
                        .hAlign(.center)
                }
                    
                
                
                if showAnimations[1] {
                    soundIcon.view()
                        .frame(width: 50, height: 50)
                        .hAlign(.center)
                        .padding(.bottom)
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        .padding(.vertical, 10)
                }
                
                
                if showAnimations[2] {
                    Text("You can also choose to play calming music while you practice.")
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        .padding(.horizontal)
                        .hAlign(.center)
                }
                
                
                if showAnimations[3] {
                    ZStack {
                        breathCircle.view()
                           .frame(width: 400, height: 400)
                           .padding(.bottom)
                           .transition(AnyTransition.opacity.animation(.easeInOut))
                           .hAlign(.center)
                        
                        if showAnimations[4] {
                            Text("Follow the breathing pattern by feeling the haptics.")
                                .fontWeight(.semibold)
                                .transition(AnyTransition.opacity.animation(.easeInOut))
                                .frame(width: 180)
                                .padding(.horizontal)
                                
                                .hAlign(.center)
                        }
                    }
                    .padding(.vertical, -25)
                    .padding(.bottom, -40)
                }
                
                
                
                    
                
                
            }
            .multilineTextAlignment(.center)
            
            
            if showAnimations[5] {
                HStack {
                    Spacer()
                    Button {
                        HapticManager.instance.impact(style: .soft)
                        hideElements()
                    } label: {
                        Text("Got It!")
                        
                            .foregroundColor(fgColor)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.vertical, 7)
                            .background {
                                RoundedRectangle(cornerRadius: 5).stroke(fgColor, lineWidth: 1)
                            }
                        
                    }
                    Spacer()
                }
                .padding(.top, 20)
                .transition(AnyTransition.opacity.animation(.easeInOut))
            }
            
            
            
            
            
            Spacer()
        }
        
        // Not sure with this one!
        .hAlign(.center).vAlign(.center)
        .font(.system(size: 14))
        .foregroundColor(fgColor)

        .lineSpacing(4)
        .padding(.vertical)
        .background(bgColor)
        .onAppear {
            stopHeartbeatTimer()
            showElements()
        }
        .onDisappear {
            stopHeartbeatTimer()
            hideElements()
        }
        .preferredColorScheme(.dark)
    }
    
    func showElements() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut) {
                showAnimations[0] = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation(.easeInOut) {
                showAnimations[1] = true
                
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            withAnimation(.easeInOut) {
                showAnimations[2] = true
                
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation(.easeInOut) {
                showAnimations[3] = true
                
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeInOut) {
                showAnimations[4] = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            withAnimation(.easeInOut) {
                showAnimations[5] = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            breathCircle.triggerInput("inhaling")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                breathCircle.triggerInput("holding")
                HapticManager.instance.imitateHeartbeat()
                startHeartbeatTimer()
            }
        }
    }
    
    func hideElements() {
        for i in 0...6 {
            withAnimation(.easeInOut) {
                showAnimations[i] = false
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            dismiss()
        }
    }
    
    func stopHeartbeatTimer() {
        heartbeatTimer.upstream.connect().cancel()
    }
    
    func startHeartbeatTimer() {
        heartbeatTimer = Timer.publish(every: 1.1, on: .main, in: .common).autoconnect()
    }
}









struct BreatheTutorialMainView: View {
    
    let fgColor: Color
    let bgColor: Color
    
    @State private var pages: BreathTutorialPages = .first
    
    var body: some View {
        VStack {
            switch pages {
            case .first:
                BreatheTutorialGuidePartOne(pages: $pages, fgColor: fgColor, bgColor: bgColor)
                    .transition(.opacity.animation(.easeInOut))
                    .preferredColorScheme(.dark)

            case .second:
                BreatheTutorialGuidePartTwo(pages: $pages, fgColor: fgColor, bgColor: bgColor)
                    .transition(.opacity.animation(.easeInOut))
                    .preferredColorScheme(.dark)

            case .third:
                BreatheTutorialGuidePartThree(pages: $pages, fgColor: fgColor, bgColor: bgColor)
                    .transition(.opacity.animation(.easeInOut))
                    .preferredColorScheme(.dark)

            }
        }
        .preferredColorScheme(.dark)
    }
}

struct BreatheTutorialGuide_Previews: PreviewProvider {
    static var previews: some View {
        //BreatheTutorialGuidePartOne(fgColor: .fg8, bgColor: .set8)
        //BreatheTutorialGuidePartTwo(fgColor: .fg8, bgColor: .set8)
        //BreatheTutorialGuidePartThree(fgColor: .fg8, bgColor: .set8)
        //BreatheTutorialMainView(fgColor: .fg8, bgColor: .set8)
            //.environmentObject(NavigationViewModel())
        
        
        RootView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationViewModel())
    }
}
