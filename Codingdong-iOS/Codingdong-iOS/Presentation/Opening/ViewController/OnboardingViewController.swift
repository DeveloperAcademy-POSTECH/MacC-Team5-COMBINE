//
//  OnboardingViewController.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/8/23.
//

import UIKit
import Combine
import Log

final class OnboardingViewController: UIViewController {
    
    private var cancellable = Set<AnyCancellable>()
    private var viewModel = OnboardingViewModel()
    
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
    
    private let doneButton = CommonButton()
    private lazy var doneButtonViewModel = CommonbuttonModel(title: "완료", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .gs10) {[weak self] in
        self?.viewModel.tapNextButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        binding()
    }
    
    private func setupView() {
        [voiceOverStackView, voiceOverTitle, voiceOverDescription, doneButton].forEach { view.addSubview($0) }
        
        doneButton.setup(model: doneButtonViewModel)
        
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
        
        doneButton.snp.makeConstraints {
            $0.top.equalTo(voiceOverDescription.snp.bottom).offset(139)
            $0.left.equalToSuperview().offset(Constants.Button.buttonPadding)
            $0.right.equalToSuperview().offset(-Constants.Button.buttonPadding)
            $0.bottom.equalToSuperview().offset(-Constants.Button.buttonPadding * 2)
        }
    }

    private func binding() {
        viewModel.route
            .sink { [weak self] nextView in
                self?.navigationController?.pushViewController(nextView, animated: false)
                self?.navigationController?.setViewControllers([nextView], animated: false)
            }
            .store(in: &cancellable)
    }
    
    // TODO: 보이스오버 추가
    private func setupAccessibility() {}
}
