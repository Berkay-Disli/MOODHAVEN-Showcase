//
//  BreatheView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import SwiftUI
import CoreHaptics

enum BreathingState: Int, CaseIterable {
    //case noAction = 19
    case inhaling = 0
    case hold = 4
    case exhaling = 11
    
    var title: String {
        switch self {
            /*
        case .noAction:
            return "Start Inhaling"
             */
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
    @State private var breathCycleCounter = 0
    @State private var breathState: BreathingState?
    @State private var timeCounter = 0
    @State private var timer = Timer.publish(every: 1.4, on: .main, in: .common).autoconnect()
    @State private var breatheStateTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isTimerRunning = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(timeCounter == 0 ? "GO":String(timeCounter))")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .animation(.easeInOut(duration: 0.2), value: timeCounter)
                .background {
                    Circle().stroke(.green, lineWidth: 10)
                        .frame(width: 120, height: 120)
                }
                .padding()
                .onReceive(timer) { _ in
                    HapticManager.instance.imitateHeartbeat()
                }
                .onReceive(breatheStateTimer, perform: { time in
                    /*
                    if timeCounter == BreathingState.noAction.rawValue {
                        breathState = .noAction
                        
                    } else
                     */if timeCounter == BreathingState.inhaling.rawValue {
                        breathState = .inhaling
                        
                    } else if timeCounter == BreathingState.hold.rawValue {
                        breathState = .hold
                        
                    } else if timeCounter == BreathingState.exhaling.rawValue {
                        breathState = .exhaling
                        
                    }
                    
                    self.timeCounter += 1
                    if self.timeCounter == 20 {
                        self.breathCycleCounter += 1
                        self.breathState = .inhaling
                        self.timeCounter = 1
                        
                        if self.breathCycleCounter == 2 {
                            self.timeCounter = 0
                            self.breathState = nil
                            stopBreathTimer()
                            stopTimer()
                        } else {
                            
                        }
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
            
            if let breathState {
                Text("\(breathState.title)")
                    .font(.largeTitle)
                    .padding()
                    .transition(AnyTransition.offset(y: -10))
                    
            }
                
        }
        .animation(.easeInOut(duration: 0.2), value: breathState)
        
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
