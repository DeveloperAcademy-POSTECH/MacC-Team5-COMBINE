//
//  TigerEncountViewController.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/11/10.
//

import UIKit
import Combine

final class TigerEncountViewController: UIViewController, ConfigUI {
    var viewModel = TigerEncounterViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let navigationTitle: UILabel = {
        let label = UILabel()
        label.text = "호랑이를 마주친 엄마"
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
    
    //private let labelComponents = TigerEncountView()
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "고개를 넘던 엄마는 호랑이를 마주치고 말았어요."
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "\"떡 하나 주면 안 잡아먹지!\""
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let thirdLabel: UILabel = {
        let label = UILabel()
        label.text = "호랑이가 엄마에게 떡을 달라며 무섭게 으르렁 거리고 있어요."
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let fourthLabel: UILabel = {
        let label = UILabel()
        label.text = "호랑이에게 줄 떡꼬치를 만들어야해요!"
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let nextButton = CommonButton()
    
    private lazy var nextButtonViewModel = CommonbuttonModel(title: "떡꼬치 만들기", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .primary2, height: 72) {[weak self] in
        self?.viewModel.moveOn()
    }
    
    private let basicPadding = Constants.Button.buttonPadding
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupNavigationBar()
        addComponents()
        setConstraints()
        setupAccessibility()
        binding()
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
        [firstLabel, secondLabel, thirdLabel, fourthLabel, nextButton].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        nextButton.setup(model: nextButtonViewModel)
        
        firstLabel.snp.makeConstraints {
            $0.top.equalTo(naviLine.snp.bottom).offset(basicPadding)
            $0.left.equalToSuperview().offset(basicPadding)
            $0.right.equalToSuperview().offset(-basicPadding)
        }
        
        secondLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(basicPadding)
            $0.right.equalToSuperview().offset(-basicPadding)
            $0.top.equalTo(firstLabel.snp.bottom).offset(basicPadding * 2)
        }
        
        thirdLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(basicPadding)
            $0.right.equalToSuperview().offset(-basicPadding)
            $0.top.equalTo(secondLabel.snp.bottom).offset(basicPadding * 2)
        }
        
        fourthLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(basicPadding)
            $0.right.equalToSuperview().offset(-basicPadding)
            $0.top.equalTo(thirdLabel.snp.bottom).offset(basicPadding * 2)
        }
        
        nextButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(basicPadding)
            $0.right.equalToSuperview().offset(-basicPadding)
            $0.bottom.equalToSuperview().offset(-basicPadding * 2)
        }
    }
    
    func setupAccessibility() {
        navigationItem.accessibilityElements = [navigationTitle, firstLabel, secondLabel, thirdLabel, fourthLabel, leftBarButtonItem]
        //view.accessibilityElements = [labelComponents.containerView, nextButton]
        leftBarButtonItem.accessibilityLabel = "내 책장"
    }
    
    func binding() {
        self.viewModel.route
            .sink { [weak self] nextView in
                self?.navigationController?.pushViewController(nextView, animated: false)
            }
            .store(in: &cancellable)
    }
        
    @objc
    func popThisView() {
        self.navigationController?.popToRootViewController(animated: false)
    }
}
