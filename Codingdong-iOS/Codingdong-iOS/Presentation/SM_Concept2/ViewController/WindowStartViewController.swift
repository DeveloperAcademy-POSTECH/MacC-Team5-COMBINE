//
//  WindowStartViewController.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 11/3/23.
//

import UIKit
import SnapKit
import Log

final class WindowStartViewController: UIViewController, ConfigUI {
    
    // MARK: - Components
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
        아직 배가 고픈 호랑이는 오누이도 잡아먹고 싶어졌어.

        그래서 엄마로 변장하는 꾀를 냈어.
        
        과연 오누이는 엄마로 변장한 호랑이를 알아차릴 수 있을까?

        오누이를 도와 문 밖의 무서운 호랑이의 정체를 밝혀보자!!
        """
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let nextButton = CommonButton()
    
    private lazy var nextButtonViewModel = CommonbuttonModel(title: "구멍엿보기",font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .primary2) { [weak self] in
        self?.navigationController?.pushViewController(WindowHoleViewController(), animated: false)
    }
    
    // MARK: - View init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupNavigationBar()
        addComponents()
        setConstraints()
        nextButton.setup(model: nextButtonViewModel)
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
        [titleLabel, nextButton].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(naviLine.snp.bottom).offset(Constants.View.padding)
            $0.left.right.equalToSuperview().inset(Constants.View.padding)
        }
        
        nextButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(Constants.Button.buttonPadding)
            $0.bottom.equalToSuperview().inset(Constants.Button.buttonPadding * 2)
            $0.height.equalTo(72)
        }
    }
    
    func setupAccessibility() {
        let leftBarButtonElement = setupLeftBackButtonItemAccessibility(label: "내 책장")
        let naviTitleElement = setupNavigationTitleAccessibility(label: navigationTitle.text ?? "타이틀 없음")
        view.accessibilityElements = [naviTitleElement, titleLabel, nextButton, leftBarButtonElement]
    }
    
    @objc
    func popThisView() {
        self.navigationController?.pushViewController(CustomAlert(), animated: false)
    }
}
