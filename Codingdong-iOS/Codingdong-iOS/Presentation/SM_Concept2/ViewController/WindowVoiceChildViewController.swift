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

final class WindowVoiceChildViewController: UIViewController, SFSpeechRecognizerDelegate, ConfigUI {
    
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
    
    var initialCountNumber: Int = 2
    @Published var isSuccessInt: Int = 0
    
    let bgView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Quiz2_bgImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    private let titleLabel: UILabel = {
        var label = UILabel()
        label.font = FontManager.p_Bold(FontSize(rawValue: 64) ?? .largetitle)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessibility()
        setupNavigationBar()
        addComponents()
        setConstraints()
        onTimerStart()
    }
    
    func setupAccessibility() {
        titleLabel.isAccessibilityElement = true
    }
    
    func addComponents() {
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        self.titleLabel.text = "\(3)"
    }
    
    func setConstraints() {
        containerView.snp.makeConstraints { $0.edges.equalToSuperview() }
        titleLabel.snp.makeConstraints { $0.centerX.centerY.equalToSuperview() }
    }
    
    func setupNavigationBar() {
        self.navigationItem.hidesBackButton = true
    }
    
    func onTimerStart() {
        mTimer = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
    }
    
    @objc func timerCallBack() {
        if initialCountNumber > 0 {
            titleLabel.text = "\(initialCountNumber)"
            DispatchQueue.main.async {
                UIAccessibility.post(notification: .announcement, argument: "\(self.initialCountNumber)")
                self.initialCountNumber -= 1
            }
        } else {
            titleLabel.text = "말해주세요"
            DispatchQueue.main.async {
                self.mTimer?.invalidate()
                UIAccessibility.post(notification: .announcement, argument: "말해주세요")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.onTimerEnd()
            }
        }
//        soundManager.playTTS(String(initialCountNumber))
    }
    
    func onTimerEnd() {
        do {
            try startRecording()
        } catch {
            // 오류 발생시 뷰 dismiss
//            soundManager.playTTS("오류가 발생했습니다. 다시 실행시켜주세요")
            dismiss(animated: false)
        }
    }
    
    /// Speech To Text 기능 구현
    private func startRecording() throws {
        
        // 작업중인 task 종료
//        if let recognitionTask = recognitionTask {
//            recognitionTask.cancel()
//            self.recognitionTask = nil
//        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.record, mode: .measurement, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            Log.e(error.localizedDescription)
        }
        
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
            // Text 일치여부 판별
            if let result = result {
                Log.t(result.bestTranscription.formattedString)

                if result.bestTranscription.formattedString.trimmingCharacters(in:.whitespacesAndNewlines) == "열어줄래요" {
                    Log.i("열어줄래용?")
                    inputNode.removeTap(onBus: 0)
                    self.stopAndChangeView(isSuccess: 0) //0
                    Log.i("열어줄래요 이후")
                } else if result.bestTranscription.formattedString == "싫어요" {
                    self.stopAndChangeView(isSuccess: 1) //1
                    inputNode.removeTap(onBus: 0)
                    Log.i("싫어요 이후")
                  
                }
            }
        }

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, _: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    private func stopAndChangeView(isSuccess: Int) {
        recognitionTask?.cancel()  
        audioEngine.stop()
        
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            Log.e(error.localizedDescription)
        }
        
        UserDefaults.standard.set(isSuccess, forKey: "key")
        self.navigationController?.pushViewController(WindowEndingViewController(), animated: false)
    }
}
