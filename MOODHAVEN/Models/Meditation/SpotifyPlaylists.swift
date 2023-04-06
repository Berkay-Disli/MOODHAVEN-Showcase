//
//  SpotifyPlaylists.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 4.04.2023.
//

import Foundation

enum SpotifyPlaylists: String, CaseIterable {
    case meditationMusic, natureSounds, whiteNoise
    case ambientMusic, binauralBeats
    
    var title: String {
        switch self {
        case .meditationMusic:
            return "Meditation Music"
        case .natureSounds:
            return "Nature Sounds"
        case .whiteNoise:
            return "White Noise"
        case .ambientMusic:
            return "Ambient Music"
        case .binauralBeats:
            return "Binaural Beats"
        }
    }
    
    var description: String {
        switch self {
        case .meditationMusic:
            return "Breathe. Sense. Feel. Transcend."
        case .natureSounds:
            return "Sounds of birds, rain and forest."
        case .whiteNoise:
            return "Helps you focus, relax or sleep."
        case .ambientMusic:
            return "Fill your mind with music for dreaming."
        case .binauralBeats:
            return "Reach peak awareness in Gamma state."
        }
    }
    
    var image: String {
        switch self {
        case .meditationMusic:
            return "meditationSpotify2"
        case .natureSounds:
            return "meditationSpotify1"
        case .whiteNoise:
            return "noiseSpotify"
        case .ambientMusic:
            return "ambientSpotify1"
        case .binauralBeats:
            return "binauralSpotify"
        }
    }
    
    // add link url to spotify
    
    var url: URL? {
        switch self {
        case .meditationMusic:
            return URL(string: "https://open.spotify.com/playlist/37i9dQZF1DX9uKNf5jGX6m?si=84cf2aca537a46ec")
        case .natureSounds:
            return URL(string: "https://open.spotify.com/playlist/37i9dQZF1DX4PP3DA4J0N8?si=31c7b8dc6dc54565")
        case .whiteNoise:
            return URL(string: "https://open.spotify.com/playlist/37i9dQZF1DWUZ5bk6qqDSy?si=c71821a91b85472b")
        case .ambientMusic:
            return URL(string: "https://open.spotify.com/playlist/1kqBP6eE24L0agNpnTIKtc?si=37f747e5d17e47f0")
        case .binauralBeats:
            return URL(string: "https://open.spotify.com/playlist/37i9dQZF1DX7EF8wVxBVhG?si=865286f01971432f")
        }
    }
}
