//
//  IfConceptViewController.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/11/10.
//

import UIKit
import SnapKit
import Log

final class IfConceptViewController: UIViewController, ConfigUI {
    
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
        label.text = "첫 번째 코딩 간식이야"
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let nextButton = CommonButton()
    
    private lazy var nextButtonViewModel = CommonbuttonModel(title: "다음 이야기", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .primary2, height: 72, didTouchUpInside: didClickNextButton)
    
    private let basicPadding = Constants.Button.buttonPadding
    
    private let cardView = CardView()
    
    private let cardViewModel = CardViewModel(title: "만약에와 아니면 떡", content: "만약에 떡과, 아니면 떡으로 엄마가 고개를 넘기 위한 장면을 두개 만들어 봤어.", cardImage: "sm_concept1")
    
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
        [titleLabel, cardView, nextButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(basicPadding)
            $0.right.equalToSuperview().offset(-basicPadding)
            $0.top.equalTo(naviLine).offset(basicPadding)
        }
        
        cardView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-142)
        }
        
        nextButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(basicPadding)
            $0.right.equalToSuperview().offset(-basicPadding)
            $0.bottom.equalToSuperview().offset(-basicPadding * 2)
        }
    }
    
    func setupAccessibility() {
        let leftBarButtonElement = setupLeftBackButtonItemAccessibility(label: "내 책장")
        let naviTitleElement = setupNavigationTitleAccessibility(label: navigationTitle.text ?? "타이틀 없음")
        view.accessibilityElements = [naviTitleElement, titleLabel, cardView, nextButton, leftBarButtonElement]
    }
}

extension IfConceptViewController {
    @objc
    func didClickNextButton() {
        CddDBService.shared.updateFood(Food(image: "img_yugwa3", concept: "조건문"))
        self.navigationController?.pushViewController(WindowStartViewController(), animated: false)
    }
    
    @objc
    func popThisView() {
        self.navigationController?.pushViewController(CustomAlert(), animated: false)
    }
}
