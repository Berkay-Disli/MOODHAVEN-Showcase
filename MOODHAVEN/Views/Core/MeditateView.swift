//
//  MeditateView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import SwiftUI

struct MeditateView: View {
    @State private var breathingState = BreathingState.hold
        
        let inhaleDuration = 4.0
        let holdDuration = 7.0
        let exhaleDuration = 8.0
        
        let hapticGenerator = UIImpactFeedbackGenerator(style: .medium)
        
        var body: some View {
            VStack {
                Text("Close your eyes and start breathing")
                    .font(.headline)
                    .padding(.top, 50)
                
                Spacer()
                
                Circle()
                    .stroke(Color.gray, lineWidth: 10)
                    .frame(width: 250, height: 250)
                
                Text(breathingState == .inhaling ? "Inhale" : breathingState == .hold ? "Hold" : breathingState == .exhaling ? "Exhale" : "")
                    .font(.title)
                    .foregroundColor(Color.gray)
                    .padding(.top, 50)
                
                Spacer()
                
                Button(action: {
                    if self.breathingState == .exhaling {
                        self.breathingState = .inhaling
                        self.hapticGenerator.impactOccurred()
                        self.runBreathingExercise()
                    } else {
                        self.breathingState = .exhaling
                    }
                }) {
                    Text(breathingState == .hold ? "Start" : "Stop")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 100, height: 50)
                        .background(.tint)
                        .cornerRadius(25)
                        .padding(.bottom, 50)
                }
            }
        }
        
        func runBreathingExercise() {
            let inhaleTime = inhaleDuration
            let holdTime = inhaleTime + holdDuration
            let exhaleTime = holdTime + exhaleDuration
            
            DispatchQueue.main.asyncAfter(deadline: .now() + inhaleTime) {
                self.breathingState = .hold
                self.hapticGenerator.impactOccurred()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + holdTime) {
                self.breathingState = .exhaling
                self.hapticGenerator.impactOccurred()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + exhaleTime) {
                self.breathingState = .exhaling
                self.hapticGenerator.impactOccurred()
            }
        }
}

struct MeditateView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationViewModel())
    }
}
