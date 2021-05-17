//
//  PlaySound.swift
//  FakeCallApp1
//
//  Created by Motoshi Suzuki on 2021/02/08.
//

import Foundation
import AVFoundation

class PlaySound {
    var audioPlayer: AVAudioPlayer!
    let audioSession = AVAudioSession.sharedInstance()
    
    func playTalkingSound() {
        let sound = UserDefaults.standard.string(forKey: "soundName")
        let audioPath = Bundle.main.path(forResource: sound, ofType: "mp3")!
        let audioURL = URL(fileURLWithPath: audioPath)
        
        try! audioPlayer = AVAudioPlayer(contentsOf: audioURL)
        audioPlayer.prepareToPlay()
        
        do {
            try audioSession.setCategory(.playAndRecord)
            try audioSession.setMode(.voiceChat)
            try audioSession.overrideOutputAudioPort(.none)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch  {
            print("Error: \(error.localizedDescription)")
        }
        
        if audioPlayer.isPlaying {
            audioPlayer.stop()
            audioPlayer.currentTime = 0
        } else {
            audioPlayer.play()
        }
    }
    
    func stopTalkingSound() {
        if audioPlayer.isPlaying  {
            audioPlayer.stop()
            audioPlayer.currentTime = 0
        }
    }
}
