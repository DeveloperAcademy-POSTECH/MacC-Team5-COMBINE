//
//  Quiz1ViewController.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 10/20/23.
//

import UIKit
import CoreMotion
import Log

final class GiveTtekkViewController: UIViewController, ConfigUI {
    var viewModel = TtekkkochiViewModel()
    private let padding = Constants.View.padding
    
    private let hapticManager = HapticManager()
    
    private let motionManager = CMMotionManager()
    
    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let navigationTitle: UILabel = {
        let label = UILabel()
        label.text = "호랑이를 마주친 엄마"
        label.font = FontManager.navigationtitle()
        label.textColor = .gs20
        return label
    }()
    
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let leftBarButton = UIBarButtonItem(
            image: UIImage(systemName: "books.vertical"),
            style: .plain,
            target: self,
            action: #selector(popThisView)
        )
        return leftBarButton
    }()
//    
    private let storyLabel: UILabel = {
        let label = UILabel()
        label.text = "앗! 호랑이가 또 떡을 요구해요! 기기를 흔들어서 떡을 주세요!"
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let ttekkStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let nextButton = CommonButton()
    
    private lazy var nextButtonViewModel = CommonbuttonModel(title: "다음", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .primary2, height: 72, didTouchUpInside: didClickNextButton)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupNavigationBar()
        setupAccessibility()
        addComponents()
        setConstraints()
        countShake()
    }
    
    func setupAccessibility() {
        navigationItem.accessibilityElements = [leftBarButtonItem, navigationTitle]
        view.accessibilityElements = [storyLabel, nextButton]
        
        leftBarButtonItem.accessibilityLabel = "내 책장"
    }
    
    func setupNavigationBar() {
        view.addSubview(naviLine)
        naviLine.snp.makeConstraints {
            // TODO: 이게 더 낫지 않을지 의논 필요
//            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalToSuperview().offset(106)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.33)
        }
        
        self.navigationController?.navigationBar.tintColor = .gs20
        self.navigationItem.titleView = self.navigationTitle
        self.navigationItem.leftBarButtonItem = self.leftBarButtonItem
    }
    
    func addComponents() {
        [storyLabel, ttekkStackView, nextButton].forEach(view.addSubview)
        nextButton.isHidden = true
        let ttekks = (1...5).map { _ in
            return self.createTtekkViews(height: 112, cornerRadius: 56)
        }
        ttekks.forEach(ttekkStackView.addArrangedSubview)
    }
    
    func setConstraints() {
        storyLabel.snp.makeConstraints {
            $0.top.equalTo(naviLine.snp.bottom).offset(padding)
            $0.left.right.equalToSuperview().inset(padding)
        }
        
        ttekkStackView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview().inset(4)
        }
        
        nextButton.setup(model: nextButtonViewModel)
        nextButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(padding)
            $0.bottom.equalToSuperview().inset(padding * 2)
        }
    }
}

extension GiveTtekkViewController {
    
    @objc
    func popThisView() {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    @objc
    private func didClickNextButton() {
        self.navigationController?.pushViewController(TigerAnimationViewController(), animated: false)
    }
    
    func createTtekkViews(height: CGFloat, cornerRadius: CGFloat) -> UIView {
        let ttekkView = UIView()
        ttekkView.backgroundColor = .white
        ttekkView.layer.cornerRadius = cornerRadius
        ttekkView.snp.makeConstraints { $0.height.equalTo(height) }
        return ttekkView
    }
    
    func handleShake() {
        let ttekks = ttekkStackView.arrangedSubviews
        
        guard let poppedView = ttekks.last else {
            self.hapticManager?.playSplash()
            self.nextButton.isHidden = false
            let newText = """
                        호랑이는 떡을 먹고도 아직 배가 고픈가봐요.
                            
                        이제는 떡이 더이상 없는데 어떡하죠?
                            
                        배고픈 호랑이가 엄마를 무섭게 노려보고 있어요.
                        """
            self.storyLabel.text = newText
            UIAccessibility.post(notification: .layoutChanged, argument: "왜 안읽지")
            return
        }
        
        ttekkStackView.removeArrangedSubview(poppedView)
        poppedView.removeFromSuperview()
        self.hapticManager?.playNomNom()
        
        //        TTS는 iOS 17 이슈로 동작하지 않음.
        //        SoundManager.shared.playTTS("\(ttekks.count)개")
        
//        //MARK: 시나리오 추가에 대한 A/B 테스트 코드.
//        let ttekks = ttekkStackView.arrangedSubviews
//        
//        guard let poppedView = ttekks.last else {
//            self.navigationController?.pushViewController(TigerAnimationViewController(), animated: false)
//            return
//        }
//        
//        ttekkStackView.removeArrangedSubview(poppedView)
//        poppedView.removeFromSuperview()
//        self.hapticManager?.playNomNom()
//        //        SoundManager.shared.playTTS("\(ttekks.count)개")
    }
    
    func countShake() {
        // CoreMotion을 사용한 방법
        // Threshold를 조절해서 인식 강도 조절 가능
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.2
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, _) in
                if let acceleration = data?.acceleration {
                    let shakeThreshold = 0.7  // 흔들기 인식 강도
                    // 흔들기 감지
                    if acceleration.x >= shakeThreshold || acceleration.y >= shakeThreshold || acceleration.z >= shakeThreshold {
                        self.handleShake()
                    }
                }
            }
        }
    }
    
}
