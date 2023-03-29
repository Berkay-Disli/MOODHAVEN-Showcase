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
                                        description: "This breathing exercise helps to calm the mind and reduce anxiety. It involves breathing in for 4 counts, holding the breath for 7 counts, and exhaling for 8 counts.",
                                        duration: 5,
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
    
    
    var body: some View {
        let fgColor = colorPreset.colorSet.fgColor
        let bgColor = colorPreset.colorSet.bgColor
        
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    Text(breathingModel.description)
                        .font(.system(size: 14))
                        .lineSpacing(4)
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    /*
                    NavigationLink("Start") {
                        BreatheActionView()
                    }
                    */
                    
                }
                .padding(.horizontal)
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
