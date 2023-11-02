//
//  Quiz1ViewController.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 10/20/23.
//

import UIKit
import SnapKit
import CoreMotion

class GiveTtekkViewController: UIViewController {
    
    private var hapticManager: HapticManager?
    
    private var maxShakeCount = 5
    
    private let rectanglesContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private var ttekkRectangleArray: [UIView] = []
    
    private lazy var motionManager = CMMotionManager()
    
    lazy var rectangleTtekkView: UIView = {
        let view = UIView()
        view.frame = .zero
        return view
    }()
    
    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let storyLabel : UILabel = {
        let label = UILabel()
        label.text = "앗! 호랑이가 또 떡을 요구해요! 기기를 흔들어서 떡을 주세요!"
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
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
        self.navigationItem.leftBarButtonItem?.accessibilityLabel = "내 책장"
        storyLabel.accessibilityTraits = .none
    }
    
    func setupNavigationBar() {
        view.addSubview(naviLine)
        naviLine.snp.makeConstraints {
            $0.top.equalToSuperview().offset(106)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.33)
        }

        self.title = "호랑이를 마주친 엄마"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.gs20, .font: FontManager.navigationtitle()]
        self.navigationController?.navigationBar.tintColor = .gs20
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "books.vertical"),
            style: .plain,
            target: self,
            action: .none
        )
    }
    
    func addComponents() {
        [storyLabel, rectanglesContainerView].forEach { view.addSubview($0) }
        ttekkStackView()
    }
    
    func setConstraints() {
        storyLabel.snp.makeConstraints {
            $0.height.equalTo(68)
            $0.width.equalTo(358)
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(122)
        }
        
        rectanglesContainerView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
    
    private func handleShake() {
        maxShakeCount -= 1
        
        if !ttekkRectangleArray.isEmpty {
            let removeTukk = ttekkRectangleArray.removeLast()
            removeTukk.removeFromSuperview()
            self.hapticManager = HapticManager()
            self.hapticManager?.playNomNom()
            SoundManager.shared.playTTS("\(maxShakeCount)개")
        } else {
            self.navigationController?.pushViewController(TigerAnimationViewController(), animated: false)
        }
    }
    
    private func countShake() {
        
        // CoreMotion을 사용한 방법
        // Threshold를 조절해서 인식 강도 조절 가능
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.2
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
                if let acceleration = data?.acceleration {
                    let shakeThreshold = 2.0  // 흔들기 인식 강도
                    // 흔들기 감지
                    if acceleration.x >= shakeThreshold || acceleration.y >= shakeThreshold || acceleration.z >= shakeThreshold {
                        self.handleShake()
                    }
                }
            }
        }
    }
    
    private func ttekkStackView() {
        for i in 0..<maxShakeCount {
            let rect = UIView()
            rect.backgroundColor = UIColor.white
            rect.layer.cornerRadius = 60
            rectanglesContainerView.addSubview(rect)
            ttekkRectangleArray.append(rect)
            
            rect.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(4)
                $0.trailing.equalToSuperview().offset(-4)
                $0.bottom.equalToSuperview().offset(-4 - i*118)
                $0.top.equalToSuperview().offset(728 - i*118)
            }
        }
    }
    
}
