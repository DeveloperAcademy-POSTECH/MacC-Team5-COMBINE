//
//  AndConceptViewController.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 11/12/23.
//

import UIKit
import SnapKit

final class AndConceptViewController: UIViewController {
    
    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let navigationTitle: UILabel = {
        let label = UILabel()
        label.text = "개념 한입"
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
        label.text = "두 번째 코딩 간식이야"
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let nextButton = CommonButton()
    
    private lazy var nextButtonViewModel = CommonbuttonModel(title: "다음 챕터로", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .gs10, height: 72, didTouchUpInside: didClickNextButton)
    
    private let basicPadding = Constants.Button.buttonPadding
    
    private let cardView = CardView()
    
    private let cardViewModel = CardViewModel(title: "그리고 과자", content: "발톱, 꼬리 그리고 수염을 확인해서 호랑이인 걸 알 수 있었어.", cardImage: "sm_concept2")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupNavigationBar()
        addComponents()
        setConstraints()
        nextButton.setup(model: nextButtonViewModel)
        cardView.config(model: cardViewModel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAccessibility()
        navigationController?.navigationBar.accessibilityElementsHidden
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
        [titleLabel, cardView, nextButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(naviLine.snp.bottom).offset(basicPadding)
            $0.left.right.equalToSuperview().inset(basicPadding)
        }
        
        cardView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(142)
        }
        
        nextButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(basicPadding)
            $0.bottom.equalToSuperview().inset(basicPadding * 2)
        }
    }
    
    func setupAccessibility() {
        let leftBarButtonElement = setupLeftBackButtonItemAccessibility(label: "내 책장")
        let naviTitleElement = setupNavigationTitleAccessibility(label: navigationTitle.text ?? "타이틀 없음")
        view.accessibilityElements = [naviTitleElement, titleLabel, cardView, nextButton, leftBarButtonElement]
    }
}

extension AndConceptViewController {
    @objc
    func didClickNextButton() {
        self.navigationController?.pushViewController(OnuiiViewController(), animated: false)
    }
    
    @objc
    func popThisView() {
        self.navigationController?.pushViewController(CustomAlert(), animated: false)
    }
}
