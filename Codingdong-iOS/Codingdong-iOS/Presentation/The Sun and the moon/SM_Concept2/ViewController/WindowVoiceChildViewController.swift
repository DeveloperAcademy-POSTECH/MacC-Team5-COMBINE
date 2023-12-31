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
    private var recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private let prevCategory = AVAudioSession.sharedInstance().category
    private let prevOptions = AVAudioSession.sharedInstance().categoryOptions
    
    @available(iOS 17, *)
    private var lmConfiguration: SFSpeechLanguageModel.Configuration {
        let outputDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let dynamicLanguageModel = outputDir.appendingPathComponent("LM")
        let dynamicVocabulary = outputDir.appendingPathComponent("Vocab")
        return SFSpeechLanguageModel.Configuration(languageModel: dynamicLanguageModel, vocabulary: dynamicVocabulary)
    }
    
//    let soundManager = SoundManager()
    
    var mTimer: Timer?
    
    var initialCountNumber: Int = 2
    @Published var isSuccessInt: Int = 0
    
    let bgView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "sm_bgView")
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
        // view.addSubview(containerView)
        [containerView, bgView].forEach { view.addSubview($0) }
        containerView.addSubview(titleLabel)
        
        self.view.bringSubviewToFront(containerView)
        self.view.bringSubviewToFront(titleLabel)
        
        self.titleLabel.text = "\(3)"
    }
    
    func setConstraints() {
        bgView.snp.makeConstraints { $0.edges.equalToSuperview() }
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
            self.announceForAccessibility("\(self.initialCountNumber)")
            titleLabel.text = "\(initialCountNumber)"
            self.initialCountNumber -= 1
        } else {
//            self.announceForAccessibility("말해 주세요.")
            titleLabel.isAccessibilityElement = false
            HapticManager.shared?.playSplash()
            titleLabel.text = "말해 주세요"
            self.mTimer?.invalidate()
            self.onTimerEnd()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            }
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
    
        do {
            try AVAudioSession.sharedInstance().setCategory(.record, mode: .measurement, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            Log.e(error.localizedDescription)
        }
        
        let inputNode = audioEngine.inputNode
        
        recognitionRequest.shouldReportPartialResults = true
        
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = true
            if #available(iOS 17, *) {
                recognitionRequest.customizedLanguageModel = self.lmConfiguration
            }
        }
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, _ in
            // Text 일치여부 판별
            if let result = result {
                Log.t(result.bestTranscription.formattedString)

                if result.bestTranscription.formattedString.trimmingCharacters(in:.whitespacesAndNewlines) == "열어줄래요" {
                    inputNode.removeTap(onBus: 0)
                    self.stopAndChangeView(isSuccess: 0) // 0
                } else if result.bestTranscription.formattedString == "싫어요" {
                    inputNode.removeTap(onBus: 0)
                    self.stopAndChangeView(isSuccess: 1) // 1
                }
            }
        }

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, _: AVAudioTime) in
            self.recognitionRequest.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    private func stopAndChangeView(isSuccess: Int) {
        recognitionTask?.finish()
        recognitionTask = nil
        audioEngine.stop()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(prevCategory, options: prevOptions)
        } catch {
            Log.e(error.localizedDescription)
        }
        
        UserDefaults.standard.set(isSuccess, forKey: "key")
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(WindowEndingViewController(), animated: false)
        }
    }
}
