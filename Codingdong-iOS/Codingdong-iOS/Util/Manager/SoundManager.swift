//
//  SoundManager.swift
//  Codingdong-iOS
//
//  Created by Joy on 10/22/23.
//

import Foundation
import AVKit
import Speech
import Log

let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko_KR"))!

var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?

var recognitionTask: SFSpeechRecognitionTask?

let audioEngine = AVAudioEngine()

var resultText: UILabel!

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
    
    func playTTS(_ text: String) {
        let speechSynthesizer = AVSpeechSynthesizer()
        let utterance: AVSpeechUtterance = {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
            utterance.rate = 0.5
            return utterance
        }()
        
        speechSynthesizer.speak(utterance)
    }
    
    func speechToText() {
        
    }
    
    func startRecording() {
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        }
        catch {}
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("")
        }
        
        // true: 말하는 즉시 변환
        // false: 종료시키면 한번에 변환
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                print("변환된 음성 : ",result?.bestTranscription.formattedString)
                resultText.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if isFinal {
                audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.startBtn.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            recognitionRequest.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        }
        catch {}
    }
}
