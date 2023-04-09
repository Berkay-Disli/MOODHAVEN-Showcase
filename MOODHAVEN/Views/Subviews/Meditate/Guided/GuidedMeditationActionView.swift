//
//  GuidedMeditationActionView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 9.04.2023.
//

import SwiftUI


struct GuidedMeditationActionView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navVM: NavigationViewModel
    let model: MeditationModel
    let fgColor: Color
    let bgColor: Color
    
    @State private var time = 0.0
    
    @StateObject var audioVM = AudioViewModel()
    @State private var showPopover = false
    
    
    var body: some View {
        VStack {
            Rectangle().fill(.clear)
                .frame(height: 100)
                .overlay(alignment: .top) {
                    HStack {
                        Image(systemName: audioVM.isPlaying ? "pause" : "play")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            //.scaleEffect(0.9)
                            .frame(width: 30, height: 27)
                            .onTapGesture {
                                if !audioVM.isPlaying {
                                    if audioVM.isPaused {
                                        audioVM.continueSound()
                                        audioVM.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

                                    } else {
                                        audioVM.playSound(model)
                                        audioVM.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                                    }
                                } else {
                                    audioVM.pauseSound()
                                }
                            }
                        
                        #warning("after continued sliders not working")
                        
                        Slider(value: $audioVM.timeValue, in: TimeInterval(0.0)...model.duration, onEditingChanged: { editing in
                            if editing {

                            } else {
                                self.audioVM.meditationAudioPlayer?.currentTime = audioVM.timeValue
                            }
                            
                        })
                            .tint(.purple)
                            
                            .onReceive(audioVM.timer) { value in
                                if self.audioVM.isPlaying {
                                    audioVM.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                                    print(value)
                                    if let currentTime = self.audioVM.meditationAudioPlayer?.currentTime {
                                        self.audioVM.timeValue = currentTime

                                        if currentTime == TimeInterval(0.0) {
                                            self.audioVM.isPlaying = false
                                        }
                                    }
                                    
                                }
                                else {
                                    //self.audioVM.isPlaying = false
                                    self.audioVM.timer.upstream.connect().cancel()
                                    print("Inside else: \(value)")
                                }
                            }
                    }
                    .padding()
                    .frame(height: 60)
                    
                    
                    
                }
                .backgroundBlur(radius: 10)
                .background(bgColor.opacity(0.2))
                .vAlign(.bottom)
                .edgesIgnoringSafeArea(.bottom)


        }
        .preferredColorScheme(.dark)
        .hAlign(.center).vAlign(.center)
        .overlay(alignment: .top, content: {
            VStack {
                HStack(content: {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(fgColor)
                            .font(.system(size: 24))
                            .padding(8)
                    }
                    
                    Spacer()
                    
                    Button {
                        showPopover.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(fgColor)
                            .font(.system(size: 24))
                            .padding(8)
                    }
                    .iOSPopover(isPresented: $showPopover, arrowDirection: .up) {
                        VStack(alignment: .leading, spacing: 12) {
                                    Text("Owner: \(model.author)")
                                        .font(.system(size: 13))
                                }
                                //.foregroundColor(.white)
                                .padding(15)
                                /*
                                .background {
                                    Rectangle()
                                        .fill(.green)
                                        .padding(-20)
                                        
                                }
                                 */
                            }
                })
                .hAlign(.center)
                .padding(.horizontal)
                .offset(y: -10)
                
                Text(model.title)
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                    .padding(.top).padding(.top)
                
             
            }
            .padding()
            
        })
        .background {
            Image(model.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
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
        GuidedMeditationActionView(model: .init(id: "guided1", title: "Set Your Intention", description: "Get inspired and create the most epic day ahead.", duration: 432, audioFileName: "Set-Your-Intention", author: "Allie - The Journey Junkie", category: nil, image: "setYourIntention"), fgColor: .fg8, bgColor: .set8)
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

