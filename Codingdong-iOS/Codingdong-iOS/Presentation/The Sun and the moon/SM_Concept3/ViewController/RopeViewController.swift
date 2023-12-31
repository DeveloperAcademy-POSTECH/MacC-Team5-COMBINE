//
//  RopeViewController.swift
//  Codingdong-iOS
//

import UIKit
import CoreMotion
import Log

final class RopeViewController: UIViewController, ConfigUI {

    private let motionManager = CMMotionManager()
    private let hapticManager = HapticManager()
    private var count = 0
    
    // MARK: - Components
    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
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
    
    private let navigationTitle: UILabel = {
       let label = UILabel()
        label.text = "동아줄을 잡은 남매와 호랑이"
        label.font = FontManager.navigationtitle()
        label.textColor = .gs20
        return label
    }()
    
    private let contentLabel: UILabel = {
       let label = UILabel()
        label.text = "휴대폰을 꽉 붙잡고 100번 흔들어보자!"
        label.textColor = .gs10
        label.font = FontManager.body()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let ropeImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ttekkset")
        imageView.contentMode = .scaleToFill
        imageView.isAccessibilityElement = true
        return imageView
    }()
    
    // MARK: - View Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupNavigationBar()
        addComponents()
        setConstraints()
        countShake()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAccessibility()
        navigationController?.navigationBar.accessibilityElementsHidden = true
    }
    
    func setupNavigationBar() {
        view.addSubview(naviLine)
        naviLine.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.33)
        }
        
        self.navigationController?.navigationBar.tintColor = .gs20
        self.navigationItem.titleView = self.navigationTitle
        self.navigationItem.leftBarButtonItem = self.leftBarButtonItem
    }
    
    func addComponents() {
        [contentLabel, ropeImage].forEach {view.addSubview($0)}
    }
    
    func setConstraints() {
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(naviLine.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        ropeImage.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(88)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
    
    func setupAccessibility() {
        let leftBarButtonElement = setupLeftBackButtonItemAccessibility(label: "내 책장")
        view.accessibilityElements = [contentLabel, ropeImage, leftBarButtonElement]
        ropeImage.accessibilityLabel = "하늘에서 내려온 동아줄이야. 얼른 붙잡고 흔들어서 올라가야해!"
        ropeImage.accessibilityTraits = .none
    }
    
    @objc func popThisView() {
        self.navigationController?.pushViewController(CustomAlert(), animated: false)
    }
    
    func countShake() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.2
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, _) in
                if let acceleration = data?.acceleration {
//
                    let shakeThreshold = 0.7  // 흔들기 인식 강도
                    // 흔들기 감지
                    if acceleration.x >= shakeThreshold || acceleration.y >= shakeThreshold || acceleration.z >= shakeThreshold {
                        self.ropeImage.image = #imageLiteral(resourceName: "ropeSet")
                        self.hapticManager?.playNomNom()
                        self.count += 1
                        
                        Log.i(self.count)
                        
                        if self.count == 10 {
                            self.motionManager.stopAccelerometerUpdates()
                            self.navigationController?.pushViewController(TeachingRepeatViewController(), animated: false)
                        }
                    }
                }
            }
        }
    }
}
