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
    let breathingModel = BreathingModel(inhaleTime: 4, holdTime: 7, exhaleTime: 3)
    let desiredBreathCycleCount = 2
    @State private var breathCycleCounter = 0
    @State private var breathState: BreathingState?
    @State private var timeCounter = 0
    @State private var timer = Timer.publish(every: 1.4, on: .main, in: .common).autoconnect()
    @State private var breatheStateTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isTimerRunning = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(timeCounter == breathingModel.totalTime! + 1 ? "GO":String(timeCounter))")
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
                    guard let totalTime = breathingModel.totalTime else { return }
                    /*
                   if timeCounter == BreathingState.inhaling.rawValue {
                        breathState = .inhaling
                        
                    } else if timeCounter == BreathingState.hold.rawValue {
                        breathState = .hold
                        
                    } else if timeCounter == BreathingState.exhaling.rawValue {
                        breathState = .exhaling
                        
                    }
                    */
                    if timeCounter == breathingModel.inhaleTime {
                         breathState = .inhaling
                         
                    } else if timeCounter == breathingModel.holdTime {
                         breathState = .hold
                         
                    } else if timeCounter == breathingModel.exhaleTime {
                         breathState = .exhaling
                         
                     }
                    
                    timeCounter -= 1
                    if timeCounter == 0 {
                        breathCycleCounter += 1
                        breathState = .inhaling
                        timeCounter = totalTime
                        
                        if breathCycleCounter == desiredBreathCycleCount {
                            timeCounter = totalTime + 1
                            breathState = nil
                            stopBreathTimer()
                            stopTimer()
                        } else {
                            
                        }
                        //startTimer()
                    }
                })
                .onTapGesture {
                    guard let totalTime = breathingModel.totalTime else { return }
                    if isTimerRunning {
                        // stop UI updates
                        stopTimer()
                        stopBreathTimer()
                    } else {
                        // start UI updates
                        timeCounter = totalTime
                        startTimer()
                        startBreathTimer()
                    }
                    isTimerRunning.toggle()
                }
                
            
            if let breathState {
                Text("\(breathState.title)")
                    .font(.largeTitle)
                    .padding()
                    .transition(AnyTransition.offset(y: -10))
                    
            }
                
        }
        .animation(.easeInOut(duration: 0.2), value: breathState)
        .onAppear {
            guard let totalTime = breathingModel.totalTime else { return }
            timeCounter = totalTime + 1
            
            stopTimer()
            stopBreathTimer()
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
