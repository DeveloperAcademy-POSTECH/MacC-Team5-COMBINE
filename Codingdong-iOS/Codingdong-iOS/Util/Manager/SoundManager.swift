//
//  SoundManager.swift
//  Codingdong-iOS
//
//  Created by Joy on 10/22/23.
//

import Foundation
import AVKit

class SoundManager {
    static let shared = SoundManager()
    var player: AVAudioPlayer?
    
    enum SoundList: String {
        case piano 
        case bell
    }
    
    func playSound(sound: SoundList) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
}
