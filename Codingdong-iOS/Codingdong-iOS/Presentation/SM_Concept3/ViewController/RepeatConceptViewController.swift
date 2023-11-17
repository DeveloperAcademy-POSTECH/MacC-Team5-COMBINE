//
//  RepeatViewController.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/13/23.
//

import UIKit
import Log
import Combine

final class RepeatConceptViewController: UIViewController, ConfigUI {
    
    // MARK: Component
    let padding = Constants.View.padding
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
        label.text = "해님달님의 세 번째 개념"
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let cardView = CardView()
    private let nextButton = CommonButton()
    
    // MARK: - ViewModel
    private var viewModel = OnuiiViewModel()
    private var cardViewModel = CardViewModel(title: "거듭하기", content: "흔들기 동작을 반복하면서 오누이가 동아줄을 오를 수 있게 도와줬어요.", cardImage: "sm_concept3")
    
    private lazy var nextButtonViewModel = CommonbuttonModel(title: "복습하기", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .gs10, height: 72) {[weak self] in
//        self?.viewModel.moveOn()
        self?.navigationController?.pushViewController(ReviewViewController(), animated: false)
    }
    
    // MARK: - View initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessibility()
        setupNavigationBar()
        addComponents()
        setConstraints()
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
        [titleLabel, cardView, nextButton].forEach { view.addSubview($0) }
        cardView.config(model: cardViewModel)
        nextButton.setup(model: nextButtonViewModel)
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(naviLine.snp.bottom).offset(padding)
            $0.left.equalToSuperview().offset(padding)
            $0.right.equalToSuperview().offset(-padding)
        }
        
        cardView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.bottom.equalToSuperview().offset(-142)
            $0.left.right.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(cardView.snp.bottom).offset(38)
            $0.left.right.equalToSuperview().inset(padding)
        }
    }
    
    func setupAccessibility() {
        navigationItem.accessibilityElements = [leftBarButtonItem, navigationTitle]
        view.accessibilityElements = [titleLabel, cardView, nextButton]
        leftBarButtonItem.accessibilityLabel = "내 책장"
    }

    @objc func popThisView() {
        self.navigationController?.popToRootViewController(animated: false)
    }
}
