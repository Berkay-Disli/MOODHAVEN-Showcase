//
//  BreatheView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import SwiftUI
import CoreHaptics

enum BreathingState {
    case inhaling
    case hold
    case exhaling
    
    var title: String {
        switch self {
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
    let breathingModel = BreathingModel(inhaleTime: 1, holdTime: 2, exhaleTime: 3)
    let desiredBreathCycleCount = 2
    
    @State private var breathCycleCounter = 0
    @State private var breathState: BreathingState?
    
    @State private var timeCounter = 0
    @State private var singleStateTimeCounter = 0
    
    @State private var timer = Timer.publish(every: 1.4, on: .main, in: .common).autoconnect()
    @State private var breatheStateTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var isTimerRunning = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("\(timeCounter == 0 ? "GO":String(timeCounter))")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .animation(.easeInOut(duration: 0.2), value: timeCounter)
                    .background {
                        
                        Gauge(value: Float(timeCounter), in: 0...Float(breathingModel.totalTime ?? 0)) {
                            }
                            .gaugeStyle(.accessoryCircularCapacity)
                            .scaleEffect(3)
                            .animation(.easeInOut, value: timeCounter)
                        
                        

                            
                    }
                    .padding()
                    // MARK: Haptic Manager Timing Below
                    .onReceive(timer) { _ in
                        HapticManager.instance.imitateHeartbeat()
                    }
                
                    // MARK: Main Timer Below
                    .onReceive(breatheStateTimer, perform: { time in
                        guard let totalTime = breathingModel.totalTime else { return }

                        if timeCounter == breathingModel.inhaleTime {
                             breathState = .inhaling
                             
                        } else if timeCounter == breathingModel.holdTime {
                             breathState = .hold
                             
                        } else if timeCounter == breathingModel.exhaleTime {
                             breathState = .exhaling
                             
                         }
                        
                        withAnimation(.easeInOut) {
                            timeCounter += 1
                        }
                        if timeCounter == totalTime + 1 {
                            breathCycleCounter += 1
                            timeCounter = 0
                            
                            if breathCycleCounter == desiredBreathCycleCount {
                                breathCycleCounter = 0
                                
                                resetBreathing()
                                
                                stopBreathTimer()
                                stopTimer()
                            } else {
                                timeCounter = 1
                            }
                            
                        }
                    })
                    .onTapGesture {
                        if isTimerRunning {
                            // stop UI updates
                            stopTimer()
                            stopBreathTimer()
                            resetBreathing()
                        } else {
                            // start UI updates
                            
                            startTimer()
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
            .background(Color.set6)
            .animation(.easeInOut(duration: 0.2), value: breathState)
            .onAppear {
                // Dont publish the timer until user wants
                stopTimer()
                stopBreathTimer()
            }
            .navigationTitle("Take a breath")
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
    
    func resetBreathing() {
        timeCounter = 0
        breathState = nil
    }
}

struct BreatheView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationViewModel())
    }
}
