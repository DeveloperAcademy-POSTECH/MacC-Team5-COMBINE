//
//  Quiz1ViewController.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 10/20/23.
//

import UIKit
import SnapKit
import CoreMotion

final class GiveTtekkViewController: UIViewController {
    
    private let padding = Constants.View.padding
    
    private let hapticManager = HapticManager()
    
    private let motionManager = CMMotionManager()
    
    private let ttekkStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let storyLabel: UILabel = {
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
            // TODO: 이게 더 낫지 않을지 의논 필요
//            $0.top.equalTo(view.safeAreaLayoutGuide)
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
            action: #selector(popThisView)
        )
    }
    
    func addComponents() {
        [storyLabel, ttekkStackView].forEach(view.addSubview)
        
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
    }
}

extension GiveTtekkViewController {
    
    @objc
    func popThisView() {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    func createTtekkViews(height: CGFloat, cornerRadius: CGFloat) -> UIView {
        let ttekkView = UIView()
        ttekkView.backgroundColor = .white
        ttekkView.layer.cornerRadius = cornerRadius
        ttekkView.snp.makeConstraints {
            $0.height.equalTo(height)
        }
        return ttekkView
    }
    
    func handleShake() {
        let ttekks = ttekkStackView.arrangedSubviews
        
        guard let poppedView = ttekks.last else {
            self.navigationController?.pushViewController(TigerAnimationViewController(), animated: false)
            return
        }
        
        ttekkStackView.removeArrangedSubview(poppedView)
        poppedView.removeFromSuperview()
        self.hapticManager?.playNomNom()
//        SoundManager.shared.playTTS("\(ttekks.count)개")
    }
    
    func countShake() {
        // CoreMotion을 사용한 방법
        // Threshold를 조절해서 인식 강도 조절 가능
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.2
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, _) in
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
    
}
