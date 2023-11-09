//
//  SplashViewController.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/8/23.
//

import UIKit
import Combine

final class SplashViewController: UIViewController {

    // MARK: Splash
    private lazy var splashContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 32
        stackView.axis = .vertical
        return stackView
    }()
    
    private let logoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "img_logo")
        imageView.contentMode = .scaleAspectFit
        imageView.isAccessibilityElement = true
        return imageView
    }()
    
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "CODINGDONG"
        label.textColor = .gs10
        label.font = FontManager.subhead()
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - View init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupView()
        setupAccessibility()
    }
    
    private func setupView() {
        view.addSubview(splashContainerView)
        [logoImageView, appNameLabel].forEach { splashContainerView.addArrangedSubview($0) }

        splashContainerView.snp.makeConstraints { $0.centerX.centerY.equalToSuperview() }
    }
    
    // TODO: 보이스오버 체크
    private func setupAccessibility() {
        view.accessibilityElements = [logoImageView, appNameLabel]
        logoImageView.accessibilityLabel = "코딩동 로고"
        appNameLabel.accessibilityLabel = "코딩동"
    }
}
