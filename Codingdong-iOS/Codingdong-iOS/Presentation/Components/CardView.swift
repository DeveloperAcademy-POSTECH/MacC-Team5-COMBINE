//
//  CardView.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/7/23.
//

import UIKit
import SnapKit

// MARK: - UIView
final class CardView: UIView {
    
    private var model: CardViewModel?
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gs10.cgColor
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = FontManager.title1()
        label.textColor = .white
        return label
    }()
    
    private let separator: UIView = {
       let view = UIView()
        view.backgroundColor = .gs30
        return view
    }()
    
    private lazy var contentLabel: UILabel = {
       let label = UILabel()
        label.font = FontManager.body()
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
        
    private lazy var conceptImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isAccessibilityElement = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        accessibilityElements = [titleLabel, contentLabel]
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    public func setupView() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(Constants.Button.buttonPadding)
        }
        
        [titleLabel, separator, contentLabel, conceptImageView].forEach { containerView.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Constants.Card.cardPadding)
            $0.top.equalToSuperview().offset(20)
        }
        separator.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.Card.cardPadding)
            $0.left.equalToSuperview().offset(Constants.Card.cardPadding)
            $0.right.equalToSuperview().offset(-Constants.Card.cardPadding)
            $0.height.equalTo(1)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(Constants.Card.cardPadding)
            $0.right.equalToSuperview().offset(-Constants.Card.cardPadding)
        }
        
        conceptImageView.snp.makeConstraints {
            $0.bottom.equalTo(containerView.snp.bottom).offset(-76)
            $0.centerX.equalToSuperview()
            
            $0.size.equalTo(CGSize(width: Constants.Card.cardSize, height: Constants.Card.cardSize))
        }
    }
}

// MARK: - ViewModel
struct CardViewModel {
    var title: String?
    var content: String?
    var cardImage: String?
    
    public init(title: String?,
                content: String?,
                cardImage: String?) {
        self.title = title
        self.content = content
        self.cardImage = cardImage
    }
}

// MARK: - Extension
extension CardView {
    public func config(model: CardViewModel) {
        self.model = model
        self.titleLabel.text = model.title
        self.contentLabel.text = model.content
        self.conceptImageView.image = UIImage(named: model.cardImage ?? "")
    }
}
