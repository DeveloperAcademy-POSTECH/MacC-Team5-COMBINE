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
    
    private var maxShakeCount = 5
    
    private let rectanglesContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private var ttekkRectangleArray: [UIView] = []
    
    private let motionManager = CMMotionManager()
    
    lazy var rectangleTtekkView: UIView = {
        let view = UIView()
        view.frame = .zero
        return view
    }()
    
    private let ttekkStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        stack.distribution = .fill
        return stack
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
            action: #selector(popThisView)
        )
    }
    
    func addComponents() {
        [storyLabel, rectanglesContainerView, ttekkStackView].forEach { view.addSubview($0) }
        /*ttekkStackView*/()
        
        let ttekks = (1...5).map { _ in
            return self.createTtekkViews(height: 112, cornerRadius: 56)
        }
        ttekks.forEach { ttekkStackView.addArrangedSubview($0) }
    }
    
    func setConstraints() {
        storyLabel.snp.makeConstraints {
            $0.top.equalTo(naviLine.snp.bottom).offset(padding)
            $0.left.right.equalToSuperview().inset(padding)
        }
        
        rectanglesContainerView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
        }
        
        ttekkStackView.snp.makeConstraints {
            $0.top.equalTo(storyLabel.snp.bottom).offset(72)
            $0.left.right.bottom.equalToSuperview().inset(4)
        }
    }
    
    //    private func makeTtekks() {
    //        let ttekks = (1...5).map { <#Int#> in
    //            <#code#>
    //        }
    //
    //        for i in 0..<maxShakeCount {
    //            let rect = UIView()
    //            rect.backgroundColor = UIColor.white
    //            rect.layer.cornerRadius = 60
    //            rectanglesContainerView.addSubview(rect)
    //            ttekkRectangleArray.append(rect)
    //
    //            rect.snp.makeConstraints {
    //                $0.leading.equalToSuperview().offset(4)
    //                $0.trailing.equalToSuperview().offset(-4)
    //                $0.bottom.equalToSuperview().offset(-4 - i*118)
    //                $0.top.equalToSuperview().offset(728 - i*118)
    //            }
    //        }
    //    }
    
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
        //        maxShakeCount -= 1
        //        if !ttekkRectangleArray.isEmpty {
        //            let removeTukk = ttekkRectangleArray.removeLast()
        //            removeTukk.removeFromSuperview()
        //            self.hapticManager = HapticManager()
        //            self.hapticManager?.playNomNom()
        //            SoundManager.shared.playTTS("\(maxShakeCount)개")
        //        } else {
        //            self.navigationController?.pushViewController(TigerAnimationViewController(), animated: false)
        //        }
        
        let ttekks = ttekkStackView.arrangedSubviews
        
        if ttekks.count != 0 {
            if let poppedView = ttekks.last {
                ttekkStackView.removeArrangedSubview(poppedView)
                ttekkStackView.removeFromSuperview()
                self.hapticManager?.playNomNom()
                SoundManager.shared.playTTS("\(ttekks.count)개")
            }
        } else {
            self.navigationController?.pushViewController(TigerAnimationViewController(), animated: false)
        }
        
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
