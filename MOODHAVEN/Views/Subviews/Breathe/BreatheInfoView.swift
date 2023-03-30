//
//  BreatheInfoView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 28.03.2023.
//

import SwiftUI

struct BreatheInfoView: View {
    let colorPreset: AppThemeColorPresets
    @Environment(\.dismiss) var dismiss
    
    let breathingModel = BreathingModel(title: "4-7-8 Breathing",
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
                                        inhaleTime: 4, holdTime: 7, exhaleTime: 8)
    
    @State private var showDescription = false
    @State private var showTimeInfo = false
    @State private var showStartButton = false
    @State private var showInstructions = false
    @State private var showNote = false
    
    
    var body: some View {
        let fgColor = colorPreset.colorSet.fgColor
        let bgColor = colorPreset.colorSet.bgColor
        
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 18) {
                    let totalCycle = (breathingModel.duration * 60) / (breathingModel.totalTime ?? 1)
                    
                    // MARK: Description
                    if showDescription {
                        Text(breathingModel.description)
                            .font(.system(size: 14))
                            .lineSpacing(4)
                            .foregroundColor(fgColor)
                            .transition(AnyTransition.opacity.animation(.easeInOut))
                    }
                    
                    // MARK: Times
                    if showTimeInfo {
                        HStack {
                            Text("\(totalCycle) cycles")
                            Spacer()
                            Text("\(breathingModel.duration) minutes")
                                
                        }
                        .foregroundColor(fgColor)
                        .padding()
                        .background(content: {
                            RoundedRectangle(cornerRadius: 6).stroke(fgColor, lineWidth: 2)
                        })
                        .fontWeight(.semibold)
                        .transition(AnyTransition.opacity.animation(.easeInOut))

                    }
                    
                    
                    // MARK: Start the exercise
                    if showStartButton {
                        NavigationLink {
                            BreatheActionView()
                        } label: {
                            Text("Start the exercise")
                                .hAlign(.center)
                            .foregroundColor(bgColor)
                            .padding()
                            .background(content: {
                                RoundedRectangle(cornerRadius: 6).fill(fgColor)
                            })
                            .fontWeight(.semibold)
                        }
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        

                    }
                    
                    // MARK: Instructions
                    if showInstructions {
                        VStack(alignment: .leading) {
                            SectionTitleView(title: "Instructions", fgColor: fgColor)
                            ForEach(breathingModel.steps, id:\.self) { step in
                                VStack(alignment: .leading) {
                                    HStack(alignment: .top) {
                                        Circle().fill(fgColor)
                                            .frame(width: 4, height: 4)
                                            .padding(.top, 6)
                                        
                                        Text(step)
                                            .foregroundColor(fgColor)
                                            .font(.system(size: 14))
                                            .lineSpacing(4)
                                    }
                                    
                                    Divider()
                                }
                                
                            }
                        }
                        .transition(AnyTransition.opacity.animation(.easeInOut))

                    }
                    
                    // MARK: Optional Note if it exists
                    if showNote {
                        if let note = breathingModel.note {
                            VStack(spacing: 8) {
                                Text("Additional Note")
                                    .fontWeight(.semibold)
                                
                                Text(note)
                                    .font(.system(size: 14))
                                    .lineSpacing(4)
                            }
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 6).stroke(fgColor, lineWidth: 2)
                            }
                            .padding(.bottom, 30)
                            .transition(AnyTransition.opacity.animation(.easeInOut))

                        }
                    }
                    
                    

                    
                    
                  
                    
                }
                .padding(.horizontal)
                .onAppear {
                    withAnimation(.easeInOut) {
                        showDescription = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.easeInOut) {
                            showTimeInfo = true
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation(.easeInOut) {
                            showStartButton = true
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        withAnimation(.easeInOut) {
                            showInstructions = true
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        withAnimation(.easeInOut) {
                            showNote = true
                        }
                    }
                   
                }
                .onDisappear {
                    showDescription = false
                    showTimeInfo = false
                    showStartButton = false
                    showInstructions = false 
                    showNote = false
                }
                
            }
            .background(bgColor)
            .navigationTitle(breathingModel.title)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(fgColor)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "info.circle")
                            .foregroundColor(fgColor)
                    }
                }
            })
            .preferredColorScheme(.dark)
            
        }
    }
}

struct BreatheInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BreatheInfoView(colorPreset: .preset8)
    }
}
