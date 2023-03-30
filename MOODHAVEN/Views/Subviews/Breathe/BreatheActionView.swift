//
//  BreatheActionView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 28.03.2023.
//

import SwiftUI

struct BreatheActionView: View {
    @EnvironmentObject private var navVM: NavigationViewModel
    @Environment(\.dismiss) var dismiss
    
    //let breathingModel = BreathingModel(inhaleTime: 4, holdTime: 7, exhaleTime: 8)
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
    
    #warning("get this from parentview")
    let desiredBreathCycleCount = 2
    
    //let breathingModel: BreathingModel
    //let desiredBreathCycleCount: Int
    
    @State private var breathCycleCounter = 0
    @State private var breathState: BreathingState?
    
    @State private var timeCounter = 0
    @State private var singleStateTimeCounter = 0
    @State private var singleStateMaxValue = 1
    
    // Inhaling haptics
    @State private var inhaleBeatTimer = Timer.publish(every: 0.17, on: .main, in: .common).autoconnect()
    // Holding haptic
    @State private var heartbeatTimer = Timer.publish(every: 1.4, on: .main, in: .common).autoconnect()
    // Exhaling haptic
    @State private var exhaleBeatTimer = Timer.publish(every: 0.35, on: .main, in: .common).autoconnect()
    
    
    @State private var breatheStateTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var isTimerRunning = false
    
    @State private var gaugeScaler: CGSize = .init(width: 2.5, height: 2.5)
    
    var body: some View {
        let fgColor = navVM.appColorPreset.colorSet.fgColor
        let bgColor = navVM.appColorPreset.colorSet.bgColor
        
        
        ZStack(alignment: .top) {
            VStack(spacing: 20) {
                Text("\(singleStateTimeCounter == 0 ? "GO":String(singleStateTimeCounter))")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(fgColor)
                    .animation(.easeInOut, value: singleStateTimeCounter)
                    .background {
                        
                        Gauge(value: Float(singleStateTimeCounter), in: 0...Float(singleStateMaxValue)) {
                        }
                        .tint(fgColor)
                        .gaugeStyle(.accessoryCircularCapacity)
                        .scaleEffect(gaugeScaler)
                        .animation(.easeInOut, value: singleStateMaxValue)
                        
                        
                        
                        
                    }
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
                            
                        } else if timeCounter == breathingModel.holdTime {
                            
                            let value = breathingModel.exhaleTime - breathingModel.holdTime
                            singleStateMaxValue = value
                            
                            // stop inhalebeat and start hold heartbeat timer
                            stopBeatTimer(breathState: .inhaling)
                            startBeatTimer(breathState: .hold)
                            
                            breathState = .hold
                            singleStateTimeCounter = 0
                            
                        } else if timeCounter == breathingModel.exhaleTime {
                            guard let totalTime = breathingModel.totalTime else { return }
                            
                            let value = totalTime - breathingModel.exhaleTime
                            singleStateMaxValue = value
                            
                            // stop hold hearbeat and start exhalebear timer
                            stopBeatTimer(breathState: .hold)
                            startBeatTimer(breathState: .exhaling)
                            
                            breathState = .exhaling
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
                            
                            if breathCycleCounter == desiredBreathCycleCount {
                                breathCycleCounter = 0
                                
                                resetBreathing()
                                
                                stopBreathTimer()
                                
                            } else {
                                timeCounter = 1
                                singleStateTimeCounter = 1
                                
                                
                                singleStateMaxValue = breathingModel.holdTime
                                
                                stopBeatTimer(breathState: .exhaling)
                                breathState = .inhaling
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
                            // start UI updates
                            startBreathTimer()
                            
                        }
                        isTimerRunning.toggle()
                    }
                
                
                if let breathState {
                    Text("\(breathState.title)")
                        .font(.largeTitle)
                        .padding(.top, 60)
                        .transition(AnyTransition.offset(y: -10))
                    
                }
                
            }
            .vAlign(.center).hAlign(.center)
            .background(bgColor)
            .animation(.easeInOut(duration: 0.2), value: breathState)
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
            
            VStack {
                Text("Info here..")
            }
            
        }
        .onAppear {
            // Parent view start button tapped
            HapticManager.instance.notification(type: .success)
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
            heartbeatTimer = Timer.publish(every: 1.4, on: .main, in: .common).autoconnect()
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
            BreatheActionView()
                .environmentObject(NavigationViewModel())
        }
    }
}
