//
//  SunAndMoonIntroView.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/11/10.
//

import UIKit
import SnapKit

/* MARK: @션 여기 리팩토링 부탁드려요 😇
(고작 라벨 하나로 해결하면 될 일을 새로운 뷰로 빼시면 어찌하옵니까: https://github.com/DeveloperAcademy-POSTECH/MacC-Team5-COMBINE/pull/60)
 여기 참조해 주세용
*/
final class SunAndMoonIntroView: UIView, ConfigUI {
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let basicPadding = Constants.Button.buttonPadding
    
    private let introLabel: UILabel = {
        let label = UILabel()
        label.text = "해님달님에서 아래의 코딩 개념들을 배워보아요!"
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let firstConceptLabel: UILabel = {
        let label = UILabel()
        label.text = "개념 1. 조건문"
        label.font = FontManager.title3()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let firstDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "호랑이랑 마주친 엄마"
        label.font = FontManager.caption2()
        label.textColor = .gs30
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let secondConceptLabel: UILabel = {
        let label = UILabel()
        label.text = "개념 2. 연산자"
        label.font = FontManager.title3()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let secondDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "남매의 집에 도착한 호랑이"
        label.font = FontManager.caption2()
        label.textColor = .gs30
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let thirdConceptLabel: UILabel = {
        let label = UILabel()
        label.text = "개념 3. 반복문"
        label.font = FontManager.title3()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let thirdDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "동아줄을 잡은 남매와 호랑이"
        label.font = FontManager.caption2()
        label.textColor = .gs30
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
        [introLabel, firstConceptLabel, firstDescriptionLabel, secondConceptLabel, secondDescriptionLabel, thirdConceptLabel, thirdDescriptionLabel].forEach {
            containerView.addSubview($0)
        }
    }
    
    func setConstraints() {
        introLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(basicPadding)
            $0.right.equalToSuperview().offset(-basicPadding)
        }
        
        firstConceptLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(basicPadding)
            $0.right.equalToSuperview().offset(-basicPadding)
            $0.top.equalTo(introLabel.snp.bottom).offset(basicPadding * 2)
        }
        
        firstDescriptionLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(basicPadding)
            $0.right.equalToSuperview().offset(-basicPadding)
            $0.top.equalTo(firstConceptLabel.snp.bottom).offset(basicPadding / 2)
        }
        
        secondConceptLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(basicPadding)
            $0.right.equalToSuperview().offset(-basicPadding)
            $0.top.equalTo(firstDescriptionLabel.snp.bottom).offset(20)
        }
        
        secondDescriptionLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(basicPadding)
            $0.right.equalToSuperview().offset(-basicPadding)
            $0.top.equalTo(secondConceptLabel.snp.bottom).offset(basicPadding / 2)
        }
        
        thirdConceptLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(basicPadding)
            $0.right.equalToSuperview().offset(-basicPadding)
            $0.top.equalTo(secondDescriptionLabel.snp.bottom).offset(20)
        }
        
        thirdDescriptionLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(basicPadding)
            $0.right.equalToSuperview().offset(-basicPadding)
            $0.top.equalTo(thirdConceptLabel.snp.bottom).offset(basicPadding / 2)
        }
    }
    
    func setupAccessibility() {
        containerView.accessibilityElements = [
            introLabel,
            firstConceptLabel,
            firstDescriptionLabel,
            secondConceptLabel,
            secondDescriptionLabel,
            thirdConceptLabel,
            thirdDescriptionLabel
        ]
        
        introLabel.accessibilityTraits = .none
        firstConceptLabel.accessibilityTraits = .none
        firstDescriptionLabel.accessibilityTraits = .none
        secondConceptLabel.accessibilityTraits = .none
        secondDescriptionLabel.accessibilityTraits = .none
        thirdConceptLabel.accessibilityTraits = .none
        thirdDescriptionLabel.accessibilityTraits = .none
        firstDescriptionLabel.accessibilityLabel = "내용"
        secondDescriptionLabel.accessibilityLabel = "내용"
        thirdDescriptionLabel.accessibilityLabel = "내용"
        firstDescriptionLabel.accessibilityValue = "호랑이랑 마주친 엄마"
        secondDescriptionLabel.accessibilityValue = "남매의 집에 도착한 호랑이"
        thirdDescriptionLabel.accessibilityValue = "동아줄을 잡은 남매와 호랑이"
    }
}
