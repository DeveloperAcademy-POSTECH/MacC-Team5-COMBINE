//
//  KPIntroViewController.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/29/23.
//

import UIKit
import Log

final class KPIntroViewController: UIViewController, ConfigUI {

    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let navigationTitle: UILabel = {
        let label = UILabel()
        label.text = "콩쥐팥쥐"
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
    
    private let introLabel: UILabel = {
        let label = UILabel()
        label.text = "콩쥐팥쥐의 각 이야기를 읽고, 다음과 같은 코딩 개념들을 함께 배워보자."
        label.isAccessibilityElement = true
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let firstConceptLabel: UILabel = {
        let label = UILabel()
        label.text = "첫번째 이야기, 배열."
        label.font = FontManager.title3()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let firstDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "콩쥐의 집안일"
        label.font = FontManager.caption2()
        label.textColor = .gs30
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let secondConceptLabel: UILabel = {
        let label = UILabel()
        label.text = "두번째 이야기, 변수."
        label.font = FontManager.title3()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let secondDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "노동 중인 콩쥐"
        label.font = FontManager.caption2()
        label.textColor = .gs30
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let thirdConceptLabel: UILabel = {
        let label = UILabel()
        label.text = "세번째 이야기, 연산자."
        label.font = FontManager.title3()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let thirdDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "꽃신의 주인은?"
        label.font = FontManager.caption2()
        label.textColor = .gs30
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let nextButton = CommonButton()
    
    private lazy var nextButtonViewModel = CommonbuttonModel(title: "시작하기", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .gs10, height: 72) {
        Log.d("시작하기")
    }
    
    private let basicPadding = Constants.Button.buttonPadding
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
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
        navigationController?.navigationBar.accessibilityElementsHidden = true
    }
    
    func addComponents() {
        [introLabel, firstConceptLabel, firstDescriptionLabel, secondConceptLabel, secondDescriptionLabel, thirdConceptLabel, thirdDescriptionLabel, nextButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        introLabel.snp.makeConstraints {
            $0.top.equalTo(naviLine.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        firstConceptLabel.snp.makeConstraints {
            $0.top.equalTo(introLabel.snp.bottom).offset(32)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        firstDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(firstConceptLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        secondConceptLabel.snp.makeConstraints {
            $0.top.equalTo(firstDescriptionLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        secondDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(secondConceptLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        thirdConceptLabel.snp.makeConstraints {
            $0.top.equalTo(secondDescriptionLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        thirdDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(thirdConceptLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        nextButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(basicPadding)
            $0.right.equalToSuperview().offset(-basicPadding)
            $0.bottom.equalToSuperview().offset(-basicPadding * 2)
        }
    }
    
    func setupAccessibility() {
         
    }
    
    func binding() {
        nextButton.setup(model: nextButtonViewModel)
    }
    
    @objc
    func popThisView() {
        navigationController?.pushViewController(CustomAlert(), animated: false)
    }
}
