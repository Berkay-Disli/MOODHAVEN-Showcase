//
//  GuidedMeditationActionView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 9.04.2023.
//

import SwiftUI


struct GuidedMeditationActionView: View {
    @EnvironmentObject var navVM: NavigationViewModel
    let model: MeditationModel
    let fgColor: Color
    let bgColor: Color
    
    @State private var time = 0.0
    
    @StateObject var audioVM = AudioViewModel()
    
    
    var body: some View {
        VStack {
            //PlayerView(player: player)
            
            
            Rectangle().fill(bgColor)
                .frame(height: 130)
                .overlay(alignment: .top) {
                    VStack {
                        Slider(value: $audioVM.timeValue, in: TimeInterval(0.0)...model.duration, onEditingChanged: { editing in
                            if editing {

                            } else {
                                self.audioVM.meditationAudioPlayer?.currentTime = audioVM.timeValue
                            }
                            
                        })
                            .tint(.purple)
                            
                            .onReceive(audioVM.timer) { _ in
                                if self.audioVM.isPlaying {
                                    if let currentTime = self.audioVM.meditationAudioPlayer?.currentTime {
                                        self.audioVM.timeValue = currentTime
                                        
                                        if currentTime == TimeInterval(0.0) {
                                            self.audioVM.isPlaying = false
                                        }
                                    }
                                    
                                }
                                else {
                                    self.audioVM.isPlaying = false
                                    self.audioVM.timer.upstream.connect().cancel()
                                }
                            }
                        
                        //Text(String(time))
                        
                        Image(systemName: audioVM.isPlaying ? "pause.circle" : "play.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .onTapGesture {
                                audioVM.playback(model)
                                audioVM.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                            }
                    }
                    .padding()
                    
                    
                }
                
                .vAlign(.bottom)
                .edgesIgnoringSafeArea(.bottom)


        }
        .preferredColorScheme(.dark)
        .hAlign(.center).vAlign(.center)
        .background {
            Image(model.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            withAnimation(.easeInOut) {
                navVM.disableTabBar()
            }
        }
        .onDisappear {
            withAnimation(.easeInOut) {
                navVM.enableTabBar()
            }
        }
    }
    
    
    func giveMinutesString(duration: TimeInterval) -> String {
        let date = Date()

        let cal = Calendar(identifier: .gregorian)
        let start = cal.startOfDay(for: date)
        let newDate = start.addingTimeInterval(duration)
        let formatter = DateFormatter()

        formatter.dateFormat = "mm:ss"

        let resultString = formatter.string(from: newDate)
        
        return resultString
    }
}

struct GuidedMeditationActionView_Previews: PreviewProvider {
    static var previews: some View {
        GuidedMeditationActionView(model: .init(id: "guided5", title: "Set Your Intention", description: "Get inspired and create the most epic day ahead.", duration: 452, audioFileName: "Set-Your-Intention", author: "Allie - The Journey Junkie", category: nil, image: "setYourIntention"), fgColor: .fg8, bgColor: .set8)
            .environmentObject(NavigationViewModel())
    }
}

/*
 struct MeditationModel: Identifiable {
 let id: String
 let title: String
 let description: String
 let duration: Int // example: "7:37"
 let audioFileName: String // name of the audio file stored locally in the app
 let author: String
 let category: String?
 let image: String
 
 }
 */
