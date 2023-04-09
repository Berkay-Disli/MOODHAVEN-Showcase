//
//  AudioViewModel.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 9.04.2023.
//

import Foundation
import AVKit

class AudioViewModel: ObservableObject {
    //static let shared = AudioViewModel()
    
    var meditationAudioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var timeValue: TimeInterval = 0.0
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var isPaused = false
    
    func playSound(_ meditationModel: MeditationModel) {
        guard let path = Bundle.main.path(forResource: "\(meditationModel.audioFileName).mp3", ofType: nil) else { return }
        
        let url = URL(filePath: path)
        do {
            meditationAudioPlayer = try AVAudioPlayer(contentsOf: url)
            try AVAudioSession.sharedInstance().setCategory(.playback)
            meditationAudioPlayer?.play()
            isPlaying = true
        } catch {
            print(error)
        }
        
    }
    
    func stopSound() {
        meditationAudioPlayer?.stop()
        meditationAudioPlayer = nil
        isPlaying = false
        timeValue = 0.0
    }
    
    func pauseSound() {
        if isPlaying == true {
            meditationAudioPlayer?.pause()
            isPlaying = false
            isPaused = true
        }
    }
    
    func continueSound() {
        if isPlaying == false {
            meditationAudioPlayer?.play()
            isPlaying = true
            isPaused = false
        }
    }
    
    
    func changeSliderValue() {
            if isPlaying == true {
                meditationAudioPlayer?.pause()
                isPlaying = false
                meditationAudioPlayer?.currentTime = timeValue
                
            }
            
            if isPlaying == false {
                meditationAudioPlayer?.play()
                isPlaying = true
            }
        }
    
}
