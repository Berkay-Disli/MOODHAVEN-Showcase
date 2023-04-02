//
//  BreatheActionView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 28.03.2023.
//

import SwiftUI
import RiveRuntime

struct BreatheActionView: View {
    
    @State private var riveBreathCircle = RiveViewModel(fileName: "breathCircle-3", stateMachineName: "State Machine 1")
    

    
    @EnvironmentObject private var navVM: NavigationViewModel
    @Environment(\.dismiss) var dismiss
    
    //let breathingModel = BreathingModel(inhaleTime: 4, holdTime: 7, exhaleTime: 8)
    let breathingModel: BreathingModel
    
    #warning("get this from parentview")
    //let desiredBreathCycleCount: Int
    
    //let breathingModel: BreathingModel
    //let desiredBreathCycleCount: Int
    
    @State private var breathCycleCounter = 0
    @State private var breathState: BreathingState?
    
    @State private var timeCounter = 0
    @State private var singleStateTimeCounter = 0
    @State private var singleStateMaxValue: Int = .max
    
    // Inhaling haptics
    @State private var inhaleBeatTimer = Timer.publish(every: 0.17, on: .main, in: .common).autoconnect()
    // Holding haptic
    @State private var heartbeatTimer = Timer.publish(every: 1.1, on: .main, in: .common).autoconnect()
    // Exhaling haptic
    @State private var exhaleBeatTimer = Timer.publish(every: 0.35, on: .main, in: .common).autoconnect()
    
    
    @State private var breatheStateTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var isTimerRunning = false
    
    @State private var gaugeScaler: CGSize = .init(width: 2.5, height: 2.5)
    
    var body: some View {
        let fgColor = navVM.appColorPreset.colorSet.fgColor
        let bgColor = navVM.appColorPreset.colorSet.bgColor
        
        
        ZStack(alignment: .bottom) {
            
            VStack(spacing: 20) {
                
                    Text("\(singleStateTimeCounter == 0 ? "GO":String(singleStateTimeCounter))")
                
                    .font(.system(size: 40))
                    .fontWeight(.light)
                    .foregroundColor(fgColor)
                    .animation(.easeInOut, value: singleStateTimeCounter)
                    .overlay(content: {
                        riveBreathCircle.view()
                            .frame(width: 380, height: 380)
                    })
                    .padding()
                // MARK: Haptic Manager Inhaling Timing Below
                    .onReceive(inhaleBeatTimer, perform: { value in
                        HapticManager.instance.impact(style: .soft)
                    })
                
                // MARK: Haptic Manager Holding Timing Below
                    .onReceive(heartbeatTimer) { _ in
                        HapticManager.instance.imitateHeartbeat()

                    }
                // MARK: Haptic Manager Exhaling Timing Below
                    .onReceive(exhaleBeatTimer, perform: { _ in
                        HapticManager.instance.impact(style: .soft)
                    })
                
                // MARK: Main Timer Below
                    .onReceive(breatheStateTimer, perform: { time in
                        guard let totalTime = breathingModel.totalTime else { return }
                        
                        if timeCounter == breathingModel.inhaleTime {
                            singleStateMaxValue = breathingModel.holdTime
                            
                            // start inhalebeat or start at the first time? -----Its the first time for now!!!
                            breathState = .inhaling
                            riveBreathCircle.triggerInput("inhaling")
                            
                        } else if timeCounter == breathingModel.holdTime {
                            
                            let value = breathingModel.exhaleTime - breathingModel.holdTime
                            singleStateMaxValue = value
                            
                            // stop inhalebeat and start hold heartbeat timer
                            HapticManager.instance.imitateHeartbeat()
                            stopBeatTimer(breathState: .inhaling)
                            startBeatTimer(breathState: .hold)
                            
                            breathState = .hold
                            riveBreathCircle.triggerInput("holding")
                            singleStateTimeCounter = 0
                            
                        } else if timeCounter == breathingModel.exhaleTime {
                            guard let totalTime = breathingModel.totalTime else { return }
                            
                            let value = totalTime - breathingModel.exhaleTime
                            singleStateMaxValue = value
                            
                            // stop hold hearbeat and start exhalebear timer
                            stopBeatTimer(breathState: .hold)
                            startBeatTimer(breathState: .exhaling)
                            
                            breathState = .exhaling
                            riveBreathCircle.triggerInput("exhaling")
                            singleStateTimeCounter = 0
                            
                        }
                        
                        withAnimation(.easeInOut) {
                            timeCounter += 1
                            singleStateTimeCounter += 1
                        }
                        if timeCounter == totalTime + 1 {
                            breathCycleCounter += 1
                            timeCounter = 0
                            singleStateTimeCounter = 0
                            
                            #warning("changed from desiredBreathCycleCount")
                            if breathCycleCounter == breathingModel.duration {
                                breathCycleCounter = 0
                                
                                resetBreathing()
                                
                                stopBreathTimer()
                                
                            } else {
                                timeCounter = 1
                                singleStateTimeCounter = 1
                                
                                
                                singleStateMaxValue = breathingModel.holdTime
                                
                                stopBeatTimer(breathState: .exhaling)
                                breathState = .inhaling
                                riveBreathCircle.triggerInput("inhaling")
                                startBeatTimer(breathState: .inhaling)
                                
                                
                            }
                        }
                    })
                    .onTapGesture {
                        if isTimerRunning {
                            // stop UI updates
                            timeCounter = 0
                            singleStateTimeCounter = 0
                            stopBreathTimer()
                            resetBreathing()
                        } else {
                            
                            if timeCounter == breathingModel.inhaleTime {
                                singleStateMaxValue = breathingModel.holdTime
                                
                                // start inhalebeat or start at the first time? -----Its the first time for now!!!
                                breathState = .inhaling
                                riveBreathCircle.triggerInput("inhaling")
                            }
                             
                            timeCounter = 1
                            singleStateTimeCounter = 1
                            // start UI updates
                            startBreathTimer()
                            
                        }
                        isTimerRunning.toggle()
                    }
            }
            .vAlign(.center).hAlign(.center)
            .background(bgColor)
            .onAppear {
                // Dont publish the timer until user wants
                stopBreathTimer()
            }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Close your eyes")
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
            
            
            if let breathState {
                Text("\(breathState.title)")
                    .font(.largeTitle)
                    .padding(.bottom, 80)
                    .transition(AnyTransition.opacity)
            }
            
            
            
        }
        .animation(.easeInOut(duration: 0.2), value: breathState)
        .onAppear {
            // Parent view start button tapped
            HapticManager.instance.impact(style: .soft)
        }
        
    }
    
    func stopBeatTimer(breathState: BreathingState) {
        switch breathState {
        case .inhaling:
            inhaleBeatTimer.upstream.connect().cancel()
        case .hold:
            heartbeatTimer.upstream.connect().cancel()
        case .exhaling:
            exhaleBeatTimer.upstream.connect().cancel()
        }
        
        withAnimation(.easeInOut) {
            gaugeScaler = CGSize(width: 2.5, height: 2.5)
        }
    }
    
    func startBeatTimer(breathState: BreathingState) {
        withAnimation(.easeInOut) {
            gaugeScaler = CGSize(width: 3, height: 3)
        }
        
        switch breathState {
        case .inhaling:
            inhaleBeatTimer = Timer.publish(every: 0.17, on: .main, in: .common).autoconnect()
        case .hold:
            heartbeatTimer = Timer.publish(every: 1.1, on: .main, in: .common).autoconnect()
        case .exhaling:
            exhaleBeatTimer = Timer.publish(every: 0.35, on: .main, in: .common).autoconnect()
        }
    }
    //---------------------
    func stopBreathTimer() {
        withAnimation(.easeInOut) {
            gaugeScaler = CGSize(width: 2.5, height: 2.5)
        }
        breatheStateTimer.upstream.connect().cancel()
        stopBeatTimer(breathState: .inhaling)
        stopBeatTimer(breathState: .hold)
        stopBeatTimer(breathState: .exhaling)
        
    }
    
    func startBreathTimer() {
        withAnimation(.easeInOut) {
            gaugeScaler = CGSize(width: 3, height: 3)
        }
        breatheStateTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        startBeatTimer(breathState: .inhaling)
    }
    
    func resetBreathing() {
        timeCounter = 0
        breathState = nil
        riveBreathCircle.triggerInput("stop")
    }
}

struct BreatheActionView_Previews: PreviewProvider {
    static var previews: some View {
        /*
         RootView()
         .preferredColorScheme(.dark)
         .environmentObject(NavigationViewModel())
         */
        NavigationView {
            BreatheActionView(breathingModel: BreathingModel(title: "4-7-8 Breathing",
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
                                                             inhaleTime: 4, holdTime: 7, exhaleTime: 8))
                .environmentObject(NavigationViewModel())
        }
    }
}
