//
//  WindowVoiceChildViewController.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 11/10/23.
//

import UIKit
import SnapKit
import Log
import Speech

final class WindowVoiceChildViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko_KR"))!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    private let audioEngine = AVAudioEngine()
    
    @available(iOS 17, *)
    private var lmConfiguration: SFSpeechLanguageModel.Configuration {
        let outputDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let dynamicLanguageModel = outputDir.appendingPathComponent("LM")
        let dynamicVocabulary = outputDir.appendingPathComponent("Vocab")
        return SFSpeechLanguageModel.Configuration(languageModel: dynamicLanguageModel, vocabulary: dynamicVocabulary)
    }
    
    let soundManager = SoundManager()
    
    var mTimer: Timer?
    var initialCountNumber: Int = 3
    
    private let containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = String(initialCountNumber)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontManager.p_Bold(FontSize(rawValue: 64) ?? .largetitle)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        Log.t("View Did Load")
        onTimerStart()
    }
    
    func onTimerStart() {
        if let timer = mTimer {
            if !timer.isValid {
                mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
            }
        } else {
            mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
        }
    }
    
    func onTimerEnd() {
        if let timer = mTimer {
            if initialCountNumber == 0 {
                timer.invalidate()
                do {
                    try startRecording()
                    titleLabel.text = "말해주세요"
                } catch {
                    // 오류 발생시 뷰 dismiss
                    soundManager.playTTS("오류가 발생했습니다. 다시 실행시켜주세요")
                    dismiss(animated: false)
                }
            }
        }
    }
    
    @objc func timerCallBack() {
        initialCountNumber -= 1
        titleLabel.text = String(initialCountNumber)
        if initialCountNumber == 0 {
            onTimerEnd()
        }
    }
    
    /// Speech To Text 기능 구현
    private func startRecording() throws {
        
        // 작업중인 task 종료
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = true
            if #available(iOS 17, *) {
                recognitionRequest.customizedLanguageModel = self.lmConfiguration
            }
        }
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            // Text 일치여부 판별
            if let result = result {
                Log.t(result.bestTranscription.formattedString)
                if result.bestTranscription.formattedString == "열어줄래요" {
                    self.stopAndChangeView(isSuccess: 0)
                    Log.i("열어줄래요 이후")
                } else if result.bestTranscription.formattedString == "싫어요" {
                    self.stopAndChangeView(isSuccess: 1)
                    Log.i("싫어요 이후")
                }
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    private func stopAndChangeView(isSuccess: Int) {
        self.recognitionTask?.cancel()
        WindowEndingViewController().isSuccess = isSuccess
        self.navigationController?.setViewControllers([MyBookShelfViewController(),WindowEndingViewController()], animated: false)
        Log.t("stopAndChangeView 내부에서 호출하는 로그")
    }
}
