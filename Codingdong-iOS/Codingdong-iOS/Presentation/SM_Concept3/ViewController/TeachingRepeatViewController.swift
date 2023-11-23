//
//  TeachingRepeatViewController.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/14/23.
//

import UIKit
import Log

final class TeachingRepeatViewController: UIViewController, ConfigUI {

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
         지금까지 10번 흔들었어.

         어때, 힘들지 않아?

         반복문을 사용하면, 원하는 횟수만큼 자동으로 반복할 수 있어!
         """
        label.textColor = .gs10
        label.font = FontManager.body()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let repeatImage: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "sm_repeat1")
        imageView.isAccessibilityElement = true
        return imageView
    }()
    
    private let tenTimesImage: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "sm_repeat3")
        return imageView
    }()
    
    private var tenTimesImageRightConstraints: NSLayoutConstraint?
    
    private let nextButton = CommonButton()
    
    private lazy var nextButtonViewModel = CommonbuttonModel(title: "다음으로", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .primary2) {[weak self] in
        self?.navigationController?.pushViewController(SunMoonOnuiiViewController(), animated: false)
    }

    // MARK: View init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupNavigationBar()
        addComponents()
        setConstraints()
        playAnimationWithVoiceOver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAccessibility()
        navigationController?.navigationBar.accessibilityElementsHidden = true
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
        [contentLabel, repeatImage, tenTimesImage, nextButton].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(naviLine.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        repeatImage.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(60)
            $0.left.equalToSuperview().offset(40)
        }
        
        tenTimesImageRightConstraints = tenTimesImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 252)
        guard let tenTimeImageRightConstraints = tenTimesImageRightConstraints else { return }
        tenTimeImageRightConstraints.isActive = true
        
        tenTimesImage.snp.makeConstraints {
            $0.centerY.equalTo(repeatImage)
        }
        
        nextButton.setup(model: nextButtonViewModel)
        nextButton.snp.makeConstraints {
            $0.top.equalTo(repeatImage.snp.bottom).offset(110)
            $0.left.right.equalToSuperview().inset(16)
        }

    }
    
    func setupAccessibility() {
        let leftBarButtonElement = setupLeftBackButtonItemAccessibility(label: "내 책장")
        view.accessibilityElements = [contentLabel, repeatImage, nextButton, leftBarButtonElement]
        
        contentLabel.accessibilityLabel = """
                                         지금까지 열번 흔들었어.

                                         어때, 힘들지 않아?

                                         반복문을 사용하면, 원하는 횟수만큼 자동으로 반복할 수 있어!
                                         """
        repeatImage.accessibilityLabel = "그럼 100번 흔드는 것도 금방 할 수 있겠지?"
        repeatImage.accessibilityTraits = .none
    }
    
    @objc func popThisView() {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    func playAnimationWithVoiceOver() {
        if UIAccessibility.isVoiceOverRunning {
            NotificationCenter.default.addObserver(self, selector: #selector(voiceOverFocusChanged), name: UIAccessibility.elementFocusedNotification, object: nil)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                self.multiTenTimesSpringAnimation()
            }
        }
    }
    
    @objc
    private func voiceOverFocusChanged(_ notification: Notification) {
        if let focusedElement = notification.userInfo?[UIAccessibility.focusedElementUserInfoKey] as? NSObject, focusedElement === repeatImage {
            self.multiTenTimesSpringAnimation()
            UIAccessibility.post(notification: .layoutChanged, argument: nil)
            Log.i("focus changed")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func multiTenTimesSpringAnimation() {
        UIView.animate(withDuration: 2,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.4,
                       options: []) { [weak self] in
            guard let self = self else { return }
            self.tenTimesImageRightConstraints?.constant = -52
            self.view.layoutIfNeeded()
        } completion: { _ in
            
        }
    }
}
