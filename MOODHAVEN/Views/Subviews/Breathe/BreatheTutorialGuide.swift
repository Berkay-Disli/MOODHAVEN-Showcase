//
//  BreatheTutorialGuide.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 3.04.2023.
//

import SwiftUI
import RiveRuntime

struct BreatheTutorialGuidePartOne: View {
    
    let fgColor: Color
    let bgColor: Color
    
    let bird1 = RiveViewModel(fileName: "bird1")
    let bird2 = RiveViewModel(fileName: "bird2")
    let doggo = RiveViewModel(fileName: "cutebear3")
    
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
    }
}

struct BreatheTutorialGuidePartTwo: View {
    let fgColor: Color
    let bgColor: Color
    
    @State private var customInhaleTime = 7
    @State private var customHoldTime = 7
    @State private var customExhaleTime = 7
    
    let breathCircle = RiveViewModel(fileName: "breathCircle-3", stateMachineName: "State Machine 1")
    
    @State private var showAnimations = [false, false, false, false, false, true]
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 16) {
            
            if showAnimations[5] {
                GreetingHeaderTextView(text: "This is the Breathe Section")
                    .padding(.top)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            }
            
            if showAnimations[0] {
                // MARK: Redacted
                VStack(spacing: 8) {
                    ForEach(1...2, id:\.self) { item in
                        RowCardView(fgColor: fgColor, title: "4-7-8 Breathing", description: "Calm your mind by slowing down your breathing.")
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
                        .padding(.vertical)
                        .hAlign(.center)
                        
                }
            }
            .multilineTextAlignment(.center)
            
            
            if showAnimations[4] {
                HStack {
                    Spacer()
                    Button {
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            withAnimation(.easeInOut) {
                showAnimations[5] = true
                
            }
        }
    }
    
    func hideElements() {
        for i in 0...5 {
            withAnimation(.easeInOut) {
                showAnimations[i] = false
            }
        }
    }
}

struct BreatheTutorialGuidePartThree: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BreatheTutorialGuide_Previews: PreviewProvider {
    static var previews: some View {
        //BreatheTutorialGuidePartOne(fgColor: .fg8, bgColor: .set8)
        BreatheTutorialGuidePartTwo(fgColor: .fg8, bgColor: .set8)
        //BreatheTutorialGuidePartThree()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationViewModel())
        
    }
}
