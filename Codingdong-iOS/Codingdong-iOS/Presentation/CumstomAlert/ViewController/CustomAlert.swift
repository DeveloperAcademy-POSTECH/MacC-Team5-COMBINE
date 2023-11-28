//
//  CustomAlert.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/11/28.
//

import UIKit
import Log

final class CustomAlert:UIViewController, ConfigUI {
    
    private let alertContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .gs80
        view.layer.cornerRadius = 14
        return view
    }()
    
    private let alertTitle: UILabel = {
        let label = UILabel()
        label.font = FontManager.callout()
        label.textColor = .white
        label.text = "메인으로"
        label.textAlignment = .center
        return label
    }()
    
    private let alertContent: UILabel = {
        let label = UILabel()
        label.font = FontManager.caption2()
        label.textColor = .white
        label.text = "동화를 나가시면 다시 처음부터 시작해요!"
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("남기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = FontManager.caption2()
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var cancelLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.font = FontManager.caption2()
        label.textColor = .white
        label.textAlignment = .center
        label.text = "남기"
        label.tag = AlertButtonType.stay.rawValue
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        label.addGestureRecognizer(labelTap)
        return label
    }()
    
    private lazy var applyLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.font = FontManager.caption2()
        label.textColor = .secondary1
        label.textAlignment = .center
        label.text = "돌아가기"
        label.tag = AlertButtonType.leave.rawValue
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        label.addGestureRecognizer(labelTap)
        return label
    }()
    
    private let horizontalLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let verticalLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupAccessibility()
        addComponents()
        setConstraints()
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func setConstraints() {
        alertContainer.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(340)
            $0.left.right.equalToSuperview().inset(62)
        }
        
        alertTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        alertContent.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(horizontalLine.snp.top).offset(-16)
        }
        
        horizontalLine.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-44)
            $0.height.equalTo(0.33)
        }
        
        verticalLine.snp.makeConstraints {
            $0.top.equalTo(horizontalLine.snp.bottom)
            $0.width.equalTo(0.33)
            $0.centerX.bottom.equalToSuperview()
        }
        
        cancelLabel.snp.makeConstraints {
            $0.top.equalTo(horizontalLine.snp.bottom).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.centerX.equalToSuperview().multipliedBy(0.5)
            $0.bottom.equalToSuperview().inset(9)
        }

        applyLabel.snp.makeConstraints {
            $0.top.equalTo(horizontalLine.snp.bottom).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.centerX.equalToSuperview().multipliedBy(1.5)
            $0.bottom.equalToSuperview().inset(9)
        }
    }
    
    func setupAccessibility() {
        
    }
    
    func addComponents() {
        view.addSubview(alertContainer)
        [alertTitle, alertContent, horizontalLine, verticalLine, cancelLabel, applyLabel].forEach { alertContainer.addSubview($0) }
    }
    
    func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
}

extension CustomAlert {
    enum AlertButtonType: Int {
        case stay = 0
        case leave = 1
    }
    
    @objc
    func buttonTapped(_ sender: UITapGestureRecognizer) {
        if let type = AlertButtonType(rawValue: sender.view?.tag ?? 0) {
            switch type {
            case .stay:
                self.navigationController?.popViewController(animated: false)
            case .leave:
                self.navigationController?.popToRootViewController(animated: false)
            }
        }
    }
}

