//
//  WindowVoiceViewController.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 11/9/23.
//

import UIKit
import SnapKit
import Log

final class WindowVoiceViewController: UIViewController, ConfigUI {

    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let navigationTitle: UILabel = {
        let label = UILabel()
        label.text = "남매의 집에 도착한 호랑이"
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = """
                    어때? 밖에 있는게
                    엄마일까, 호랑이일까?
                    문을 열어줘도 될까?
                    """
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.sizeToFit()
        return label
    }()
    
    private let doorWithHolesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "doorWithHoles")
        return imageView
    }()
    
    private let yesButton = CommonButton()
    private lazy var yesButtonViewModel = CommonbuttonModel(title: "열어줄래", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .primary2, height: 72) { [weak self] in
        UserDefaults.standard.set(0, forKey: "key")
        self?.navigationController?.pushViewController(WindowEndingViewController(), animated: false)
    }
    
    private let noButton = CommonButton()
    private lazy var noButtonViewModel = CommonbuttonModel(title: "안 열어줄래", font: FontManager.textbutton(), titleColor: .white, backgroundColor: .primary1, height: 72) { [weak self] in
        UserDefaults.standard.set(1, forKey: "key")
        self?.navigationController?.pushViewController(WindowEndingViewController(), animated: false)
    }
    
    private let buttonHorizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupAccessibility()
        setupNavigationBar()
        addComponents()
        setConstraints()
        yesButton.setup(model: yesButtonViewModel)
    }

    func setupNavigationBar() {
        view.addSubview(naviLine)
        naviLine.snp.makeConstraints {
            $0.top.equalToSuperview().offset(106)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.33)
        }
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.tintColor = .gs20
        self.navigationItem.titleView = self.navigationTitle
        self.navigationItem.leftBarButtonItem = self.leftBarButtonItem
    }
    
    func addComponents() {
        [titleLabel, doorWithHolesImageView, buttonHorizontalStack].forEach {
            view.addSubview($0)
        }
        [yesButton, noButton].forEach(buttonHorizontalStack.addArrangedSubview)
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(naviLine.snp.bottom).offset(Constants.View.padding)
            $0.left.right.equalToSuperview().inset(Constants.View.padding)
        }
        
        doorWithHolesImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(256)
            $0.left.right.equalToSuperview().inset(51)
            $0.bottom.equalToSuperview().inset(118)
        }
        
        yesButton.setup(model: yesButtonViewModel)
        noButton.setup(model: noButtonViewModel)
        
        buttonHorizontalStack.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(Constants.Button.buttonPadding)
            $0.bottom.equalToSuperview().inset(Constants.Button.buttonPadding * 2)
        }
    }
    
    func setupAccessibility() {
        let leftBarButtonElement = setupLeftBackButtonItemAccessibility(label: "내 책장")
        view.accessibilityElements = [titleLabel, yesButton, noButton, leftBarButtonElement]
        titleLabel.accessibilityLabel = """
                                        문 바끌 확인해보니 어때?
                                        엄마일까, 호랑이일까?
                                        문을 열어줘도 될까?
                                        """
    }
    
    @objc
    func popThisView() {
        self.navigationController?.popToRootViewController(animated: false)
    }

}
