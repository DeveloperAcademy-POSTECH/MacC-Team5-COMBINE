//
//  TigerAnimationViewController.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/10/23.
//

import UIKit

final class TigerAnimationViewController: UIViewController, ConfigUI {
    
    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "떡을 모두 빼앗긴 엄마는 호랑이에게 잡아먹히고 말았어요."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        
        return label
    }()
    
    private let animationView = TigerLottieAnimationView()
    
    private var btnBottomConstraints: NSLayoutConstraint?
    
    private let nextButton = CommonButton()
    
    private lazy var nextButtonViewModel = CommonbuttonModel(title: "다음", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .primary2, height: 72, didTouchUpInside: didClickNextButton)
    
    private let leftBarButtonItem: UIBarButtonItem = {
        let leftBarButton = UIBarButtonItem(
            image: UIImage(systemName: "books.vertical"),
            style: .plain,
            target: self,
            // TODO: StorySelectView 작업 후 연결하기
            action: .none
        )
        
        return leftBarButton
    }()
    
    private let navigationTitle: UILabel = {
        let label = UILabel()
        label.text = "호랑이를 마주친 엄마"
        label.font = FontManager.navigationtitle()
        label.textColor = .gs20
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        
        // TODO: NavBar 디자인 component로 나오면 수정하기
        setupNavigationBar()
        addComponents()
        setConstraints()
        nextButton.setup(model: nextButtonViewModel)
        setupAccessibility()
        
//        LottieManager.shared.playAnimation(inView: animationView.lottieView) { (finished) in
//            if finished { self.bottomBtnSpringAnimation() }
//        }
        
        // TODO: VoiceOver가 titleLabel을 읽고 실행하도록 수정해야함.
        //        if UIAccessibility.isVoiceOverRunning {
        //            // VoiceOver가 실행 중인 경우
        //            print("VoiceOver is running on the device.")
        //            notifyUserAfterReading()
        //        } else {
        //            // VoiceOver가 실행 중이 아닌 경우
        //            print("VoiceOver is not running on the device.")
        //            LottieManager.shared.playAnimation(inView: animationView.lottieView) { (finished) in
        //                if finished { self.bottomBtnSpringAnimation() }
        //            }
        //        }
        
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
        [titleLabel, animationView, nextButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(122)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        animationView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        btnBottomConstraints = nextButton.bottomAnchor.constraint(equalTo: super.view.bottomAnchor, constant: 72)
        guard let bottomConstraints = btnBottomConstraints else { return }
        bottomConstraints.isActive = true
        
        nextButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Constants.Button.buttonPadding)
            $0.right.equalToSuperview().offset(-Constants.Button.buttonPadding)
        }
    }
    
    func setupAccessibility() {
        view.accessibilityElements = [leftBarButtonItem, navigationTitle, titleLabel, nextButton]
        
        leftBarButtonItem.accessibilityLabel = "내 책장"
        leftBarButtonItem.accessibilityTraits = .button
        
        navigationTitle.accessibilityLabel = "호랑이를 마주친 엄마"
        navigationTitle.accessibilityTraits = .header
        navigationTitle.accessibilityHint = "세 페이지 중에 마지막 페이지"
        
        titleLabel.accessibilityLabel = "떡을 모두 빼앗긴 엄마는 호랑이에게 잡아먹히고 말았어요."
        titleLabel.accessibilityTraits = .none
        
        nextButton.accessibilityLabel = "다음"
        nextButton.accessibilityTraits = .button
    }
}

extension TigerAnimationViewController {
    
    private func bottomBtnSpringAnimation() {
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.4,
                       options: []) { [weak self] in
            guard let self = self else { return }
            self.navigationController?.navigationBar.isHidden = true
            self.btnBottomConstraints?.constant = -Constants.Button.buttonPadding * 2
            self.view.layoutIfNeeded()
        } completion: { _ in
            
        }
    }
    
    @objc func didClickNextButton() {
        // TODO: 다음 화면으로 내비게이션 연결 추가해야함.
        // TODO: 버튼에 액션 연결되지 않은 상태.
        LottieManager.shared.removeAnimation(inView: animationView)
        self.navigationController?.isNavigationBarHidden = true
        print("너무 아름다운 다운 다운 다운 View")
        return
    }
    
    private func notifyUserAfterReading() {
        // VoiceOver로 UI 요소를 읽도록 요청
        UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: titleLabel)
        
        // 사용자 지정 이벤트를 발생시키거나 처리
        // 이곳에서 원하는 동작 수행
        print("voiceOver")
        
        LottieManager.shared.playAnimation(inView: animationView.lottieView) { (finished) in
            if finished { self.bottomBtnSpringAnimation() }
        }
    }
}
