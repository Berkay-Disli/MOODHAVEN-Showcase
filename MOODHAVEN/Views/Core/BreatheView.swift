//
//  BreatheView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import SwiftUI
import CoreHaptics

enum BreathingState: Int, CaseIterable {
    case noAction = 19
    case inhaling = 0
    case hold = 4
    case exhaling = 11
    
    var title: String {
        switch self {
        case .noAction:
            return "Start Inhaling"
        case .inhaling:
            return "Inhale"
        case .hold:
            return "Hold your breath"
        case .exhaling:
            return "Exhale.."
        }
    }
}

struct BreatheView: View {
    @State private var timeCounter = 0
    @State private var breatheText = "Heartbeat.."
    @State private var timer = Timer.publish(every: 1.4, on: .main, in: .common).autoconnect()
    @State private var breatheStateTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isTimerRunning = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("\(breatheText): \(timeCounter)")
                .font(.largeTitle)
                .padding()
                .onReceive(timer) { _ in
                    HapticManager.instance.imitateHeartbeat()
                }
                .onReceive(breatheStateTimer, perform: { time in
                    if timeCounter == BreathingState.noAction.rawValue {
                        breatheText = BreathingState.noAction.title
                    } else if timeCounter == BreathingState.inhaling.rawValue {
                        breatheText = BreathingState.inhaling.title
                    } else if timeCounter == BreathingState.hold.rawValue {
                        breatheText = BreathingState.hold.title
                    } else if timeCounter == BreathingState.exhaling.rawValue {
                        breatheText = BreathingState.exhaling.title
                    }
                    
                    self.timeCounter += 1
                    if self.timeCounter == 20 {
                        self.timeCounter = 0
                        stopBreathTimer()
                        //startTimer()
                    }
                })
                .onTapGesture {
                    if isTimerRunning {
                        // stop UI updates
                        stopTimer()
                        stopBreathTimer()
                    } else {
                        // start UI updates
                        startTimer()
                        startBreathTimer()
                    }
                    isTimerRunning.toggle()
                }
                .onAppear {
                    stopTimer()
                    stopBreathTimer()
                }
        }
        
    }
    
    func stopTimer() {
        timer.upstream.connect().cancel()
        
    }
    
    func startTimer() {
        timer = Timer.publish(every: 1.4, on: .main, in: .common).autoconnect()
    }
    //---------------------
    func stopBreathTimer() {
        breatheStateTimer.upstream.connect().cancel()
        
    }
    
    func startBreathTimer() {
        breatheStateTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    
}

struct BreatheView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationViewModel())
    }
}
