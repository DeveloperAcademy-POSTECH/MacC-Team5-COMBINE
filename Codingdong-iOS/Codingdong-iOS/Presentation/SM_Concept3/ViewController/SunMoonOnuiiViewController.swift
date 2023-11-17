//
//  SunMoonOnuiiViewController.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/13/23.
//

import UIKit
import Combine
import Log

final class SunMoonOnuiiViewController: UIViewController, ConfigUI {

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
        label.text = """
        오누이는 동아줄을 올라
        해와 달이 되었답니다.
        """
        label.textColor = .gs10
        label.font = FontManager.body()
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let nextButton = CommonButton()
    private lazy var nextButtonViewModel = CommonbuttonModel(title: "다음", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .primary2) {[weak self] in
        self?.navigationController?.pushViewController(RepeatConceptViewController(), animated: false)
    }
    
    lazy var lottieView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        LottieManager.shared.setAnimationForOnui(named: "OnuiAnimation_Fixed", inView: view)
        return view
    }()
    
    // MARK: - View Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessibility()
        setupNavigationBar()
        addComponents()
        setConstraints()
//        playAnimationWithVoiceOver()
        if UIAccessibility.isVoiceOverRunning {
            NotificationCenter.default.addObserver(self, selector: #selector(voiceOverFocusChanged), name: UIAccessibility.elementFocusedNotification, object: nil)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
//                LottieManager.shared.playWithProgressTimeAnimation(inView: self.lottieView, from: 0, to: 0.8, completion: nil)
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupNavigationBar() {
        view.addSubview(naviLine)
        naviLine.snp.makeConstraints {
            $0.top.equalToSuperview().offset(106)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.33)
        }
        self.navigationController?.navigationBar.tintColor = .gs20
        self.navigationItem.titleView = self.navigationTitle
        self.navigationItem.leftBarButtonItem = self.leftBarButtonItem
    }
    
    func addComponents() {
        [contentLabel, lottieView, nextButton].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(naviLine.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        lottieView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        nextButton.setup(model: nextButtonViewModel)
        nextButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Constants.Button.buttonPadding)
            $0.right.equalToSuperview().offset(-Constants.Button.buttonPadding)
            $0.bottom.equalToSuperview().offset(-Constants.Button.buttonPadding*2)
        }
        
    }
    
    func setupAccessibility() {
        navigationItem.accessibilityElements = [leftBarButtonItem, navigationTitle]
        view.accessibilityElements = [contentLabel, nextButton]
        leftBarButtonItem.accessibilityLabel = "내 책장"
    }
    
}

extension SunMoonOnuiiViewController {
    
    @objc private func popThisView() {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    func playAnimationWithVoiceOver() {
        if UIAccessibility.isVoiceOverRunning {
            NotificationCenter.default.addObserver(self, selector: #selector(voiceOverFocusChanged), name: UIAccessibility.elementFocusedNotification, object: nil)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
//                LottieManager.shared.playWithProgressTimeAnimation(inView: self.lottieView, from: 0, to: 0.8, completion: nil)
            }
        }
    }
    
    @objc
    private func voiceOverFocusChanged(_ notification: Notification) {
        if let focusedElement = notification.userInfo?[UIAccessibility.focusedElementUserInfoKey] as? NSObject, focusedElement === contentLabel {
            LottieManager.shared.playAnimation(inView: self.lottieView, completion: nil)
            LottieManager.shared.removeAnimation(inView: self.lottieView)
            UIAccessibility.post(notification: .layoutChanged, argument: nil)
        }
    }
    
}
