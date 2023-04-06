//
//  MeditateTutorialPage2.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 4.04.2023.
//

import SwiftUI
import RiveRuntime

struct MeditateTutorialPage2: View {
    @Binding var pages: MeditateTutorialPages
    
    @Environment(\.dismiss) var dismiss


    let fgColor: Color
    let bgColor: Color
    
    let girl = RiveViewModel(fileName: "meditateGirl")

    
    @State private var showAnimations = [false, false, false, false, false, true]
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 16) {
            
            if showAnimations[5] {
                GreetingHeaderTextView(text: "Guided Meditations")
                    .padding(.top)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            }
            
            VStack(alignment: .leading, spacing: 0) {
                
                if showAnimations[0] {
                    Text("Choose from a variety of guided meditations to help you find peace in your daily life.")
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        .padding()
                        .hAlign(.center)
                }
                    
                if showAnimations[1] {
                    girl.view()
                        .frame(height: 250)
                        .hueRotation(Angle(degrees: 270))
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                }
                
                
                
                if showAnimations[2] {
                    Text("These meditations are designed to be accessible, easy to follow and help you achieve a deep sense of relaxation and focus.")
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        .padding()
                        .padding(.top)
                        .hAlign(.center)
                }
                
                if showAnimations[3] {
                    Text("Try to give yourself the time and space to fully immerse yourself in the practice.")
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        .padding()
                        .padding(.top, 8)
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
                        Text("Got It!")
                        
                            .foregroundColor(fgColor)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.vertical, 7)
                            .background {
                                RoundedRectangle(cornerRadius: 5).stroke(fgColor, lineWidth: 1)
                            }
                        
                    }
                    .padding(.top, 7)
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
            dismiss()
        }
    }
}

struct MeditateTutorialPage2_Previews: PreviewProvider {
    static var previews: some View {
        MeditateTutorialPage2(pages: .constant(.second), fgColor: .fg8, bgColor: .set8)
    }
}
