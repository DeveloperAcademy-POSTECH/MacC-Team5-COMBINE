//
//  CommonButton.swift
//  Codingdong-iOS
//
//  Created by Joy on 10/19/23.
//

import UIKit

final class CommonButton: UIView {

    private var button: UIButton!
    private var model: CommonbuttonModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView() {
        clipsToBounds = true
        
        self.button = {
            let button = UIButton(type: .custom)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(self.touchUpInside), for: .touchUpInside)
            return button
        }()
        
        self.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    public func setup(model: CommonbuttonModel) {
        self.backgroundColor = model.backgroundColor
        self.button.setTitle(model.title, for: .normal)
        self.button.setTitleColor(model.titleColor, for: .normal)
        self.button.titleLabel?.font = model.font
        self.layer.cornerRadius = model.cornerRadius
        
        NSLayoutConstraint.activate([
            self.button.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.button.heightAnchor.constraint(equalToConstant: model.height)
        ])
    }

    @objc private func touchUpInside() {
        self.model?.didTouchUpInside?()
    }
}

final class CommonbuttonModel: NSObject {
    var title: String?
    var font: UIFont
    var titleColor: UIColor
    var backgroundColor: UIColor
    var height: CGFloat
    var cornerRadius: CGFloat
    
    let didTouchUpInside: (() -> Void)?
    
    public init(title: String? = nil,
                font: UIFont,
                titleColor: UIColor,
                backgroundColor: UIColor,
                height: CGFloat = 72,
                cornerRadius: CGFloat = 36,
                didTouchUpInside: ( () -> Void)? = nil) {
        self.title = title
        self.font = font
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.height = height
        self.cornerRadius = cornerRadius
        self.didTouchUpInside = didTouchUpInside
    }
}
