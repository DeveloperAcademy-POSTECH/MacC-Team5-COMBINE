//
//  TigerEncountView.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/11/10.
//

import UIKit
import SnapKit

final class TigerEncountView: UIView, ConfigUI {
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let basicPadding = Constants.Button.buttonPadding
    
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
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        setupAccessibility()
        addComponents()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupNavigationBar() {
        
    }
    
    func addComponents() {
        [firstLabel, secondLabel, thirdLabel, fourthLabel].forEach {
            containerView.addSubview($0)
        }
    }
    
    func setConstraints() {
        firstLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
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
    }
    
    func setupAccessibility() {
        containerView.accessibilityElements = [ firstLabel, secondLabel, thirdLabel, fourthLabel ]
        
        firstLabel.accessibilityTraits = .none
        secondLabel.accessibilityTraits = .none
        thirdLabel.accessibilityTraits = .none
        fourthLabel.accessibilityTraits = .none

        firstLabel.accessibilityLabel = "본문"
        firstLabel.accessibilityValue = "고개를 넘던 엄마는 호랑이를 마주치고 말았어요."
    }
}
