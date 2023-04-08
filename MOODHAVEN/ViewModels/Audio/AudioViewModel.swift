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
    
    func playback(_ meditationModel: MeditationModel) {
        if isPlaying {
            meditationAudioPlayer?.stop()
            isPlaying = false
            meditationAudioPlayer = nil
        } else {
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
