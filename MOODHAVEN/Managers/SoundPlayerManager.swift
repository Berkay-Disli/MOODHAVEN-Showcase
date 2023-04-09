//
//  SoundPlayerManager.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 9.04.2023.
//

import Foundation
import AVFoundation

class SoundPlayerManager: ObservableObject {
    
    
    var audioPlayer: AVAudioPlayer?
    let fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
        
        if let soundUrl = Bundle.main.url(forResource: fileName, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundUrl)
                audioPlayer?.numberOfLoops = -1
            } catch {
                print("Error loading audio file: \(error)")
            }
        }
    }
    
    func start() {
        audioPlayer?.setVolume(0.5, fadeDuration: 0)
        audioPlayer?.play()
        
        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.audioPlayer?.setVolume(0.5, fadeDuration: 2)
        }
        */
    }
    
    func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    func pause() {
        audioPlayer?.pause()
    }
    
    deinit {
        stop()
    }
    
    func startBackgroundAudio() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.start()
        }
    }
}
