//
//  SunAndMoonIntroViewController.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/11/08.
//

import UIKit
import SnapKit

final class SunAndMoonIntroViewController: UIViewController, ConfigUI {
    
    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let navigationTitle: UILabel = {
        let label = UILabel()
        label.text = "해님 달님"
        label.font = FontManager.navigationtitle()
        label.textColor = .gs20
        return label
    }()
    
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let leftBarButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(popThisView)
        )
        return leftBarButton
    }()
    
    private let labelComponents = SunAndMoonIntroView()
    
    private let nextButton = CommonButton()
    
    private lazy var nextButtonViewModel = CommonbuttonModel(title: "시작하기", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .gs10, height: 72, didTouchUpInside: didClickNextButton)
    
    private let basicPadding = Constants.Button.buttonPadding
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupNavigationBar()
        addComponents()
        setConstraints()
        setupAccessibility()
        nextButton.setup(model: nextButtonViewModel)
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
        [labelComponents, nextButton].forEach {
            view.addSubview($0)
        }
        
    }
    
    func setConstraints() {
        labelComponents.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalTo(naviLine).offset(basicPadding)
        }
        
        nextButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(basicPadding)
            $0.right.equalToSuperview().offset(-basicPadding)
            $0.bottom.equalToSuperview().offset(-basicPadding * 2)
        }
    }
    
    func setupAccessibility() {
        navigationItem.accessibilityElements = [leftBarButtonItem, navigationTitle]
        view.accessibilityElements = [
            labelComponents.containerView, nextButton
        ]
    }
}

extension SunAndMoonIntroViewController {
    @objc
    func didClickNextButton() {
        // TODO: 다음 화면으로 내비게이션 연결 추가해야함.
        // TODO: 버튼에 액션 연결되지 않은 상태.
        self.navigationController?.pushViewController(TigerEncountViewController(), animated: false)
    }
    
    @objc
    func popThisView() {
        self.navigationController?.popViewController(animated: false)
    }
}
