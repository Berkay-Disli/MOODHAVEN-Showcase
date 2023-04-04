//
//  MeditateTutorialPage1.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 4.04.2023.
//

import SwiftUI
import RiveRuntime

struct MeditateTutorialPage1: View {
    @Binding var pages: MeditateTutorialPages
    
    let fgColor: Color
    let bgColor: Color
    
    let wanderingMind = RiveViewModel(fileName: "wandering")
    
    @State private var showAnimations = [false, false, false, false, true]
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 16) {
            
            if showAnimations[4] {
                GreetingHeaderTextView(text: "Wandering Mind?")
                    .padding(.top)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            }
            
            if showAnimations[0] {
                    wanderingMind.view()
                        .frame(height: 500)
                        .padding(.vertical, -40)
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                    
            }
            
            VStack(alignment: .leading, spacing: 15) {
                
                if showAnimations[1] {
                    Text("Is your mind racing? Maybe you are struggling to stay present. Take a deep breath.")
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        .padding(.horizontal)
                        .padding(.bottom)
                        .hAlign(.center)

                }
                    
                
                
                
                if showAnimations[2] {
                    Text("Welcome to the meditate tab. Here, you can find a variety of guided meditations, playlists, and resources to help you on your journey to mindfulness.")
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        .padding(.horizontal)
                        .hAlign(.center)

                }
            }
            .multilineTextAlignment(.center)
            
            
            if showAnimations[3] {
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
        
    }
    
    func hideElements() {
        for i in 0...4 {
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

struct MeditateTutorialPage1_Previews: PreviewProvider {
    static var previews: some View {
        MeditateTutorialPage1(pages: .constant(.first), fgColor: .fg8, bgColor: .set8)
    }
}
