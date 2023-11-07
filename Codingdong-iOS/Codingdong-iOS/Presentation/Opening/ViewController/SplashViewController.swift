//
//  SplashViewController.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/8/23.
//

import UIKit

final class SplashViewController: UIViewController {
    
    private lazy var containerView: UIStackView = {
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
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "CODINGDONG"
        label.textColor = .gs10
        label.font = FontManager.subhead()
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupView()
        setupAccessibility()
    }
    
    func setupView() {
        view.addSubview(containerView)
        [logoImageView, nameLabel].forEach { containerView.addArrangedSubview($0) }
        containerView.snp.makeConstraints { $0.centerX.centerY.equalToSuperview() }
    }
    
    // TODO: 보이스오버 체크
    func setupAccessibility() {
        view.accessibilityElements = [logoImageView, nameLabel]
        logoImageView.accessibilityLabel = "코딩동 로고"
        nameLabel.accessibilityLabel = "코딩동"
    }
    
}
