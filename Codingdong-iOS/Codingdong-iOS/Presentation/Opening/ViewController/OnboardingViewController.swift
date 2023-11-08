//
//  OnboardingViewController.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/8/23.
//

import UIKit
import Combine

final class OnboardingViewController: UIViewController {
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Components
    private lazy var voiceOverStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.alignment = .center
        
        let imageView: UIImageView = {
           let image = UIImageView()
            image.image = UIImage(named: "img_accessibility")
            image.contentMode = .scaleAspectFit
            return image
        }()
        
        stackView.addArrangedSubview(imageView)
        return stackView
    }()
    
    private let voiceOverTitle: UILabel = {
       let label = UILabel()
        label.text = "VoiceOver 설정"
        label.font = FontManager.headline()
        label.textColor = .gs20
        label.textAlignment = .center
        return label
    }()
    
    private let voiceOverDescription: UILabel = {
       let label = UILabel()
        label.text = """
        손쉬운 사용의 VoiceOver를
        켜시면 오디오 설명과 함께
        코딩동을 즐길 수 있어요
        """
        label.textAlignment = .center
        label.font = FontManager.footnote()
        label.numberOfLines = 0
        label.textColor = .gs20
        return label
    }()
    
    // TODO: 버튼 추가
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        //setupAccessibility()
    }
    
    private func setupView() {
        [voiceOverStackView, voiceOverTitle, voiceOverDescription].forEach { view.addSubview($0) }
        
        voiceOverStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(220)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        voiceOverTitle.snp.makeConstraints {
            $0.top.equalTo(voiceOverStackView.snp.bottom).offset(80)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        voiceOverDescription.snp.makeConstraints {
            $0.top.equalTo(voiceOverTitle.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
    }

    // TODO: 보이스오버 추가
    private func setupAccessibility() {}
    
}
