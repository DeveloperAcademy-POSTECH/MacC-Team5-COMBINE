//
//  MoreBadgeCollectionViewCell.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/11/10.
//

//import UIKit
//import SnapKit
//
//class MoreBadgeCollectionViewCell: UICollectionViewCell {
//    
//    static let identifier = "MoreBadgeCollectionViewCell"
//
//    private let containerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .clear
//        return view
//    }()
//    
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = FontManager.subhead()
//        label.textColor = .gs40
//        label.text = "해님달님"
//        return label
//    }()
//    
//    private let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = .clear
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()
//    
//    private let conceptLabel: UILabel = {
//        let label = UILabel()
//        label.font = FontManager.caption2()
//        label.textColor = .gs40
//        return label
//    }()
//    
//    private let horizontalStack: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .horizontal
//        stack.spacing = Constants.Button.buttonPadding
//        stack.alignment = .center
//        stack.distribution = .fillEqually
//        return stack
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setUI()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setUI() {
//        addSubview(containerView)
//        containerView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        
//        containerView.addSubview(titleLabel)
//        titleLabel.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.left.equalToSuperview()
//        }
//        
//        containerView.addSubview(horizontalStack)
//        horizontalStack.snp.makeConstraints {
//            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
//            $0.left.equalToSuperview()
//            $0.right.equalToSuperview()
//        }
//    }
//    
//    func configure(with badges: [Badge], title: String) {
//        titleLabel.text = title
//        
//        for badge in badges {
//            let verticalStack = UIStackView()
//            verticalStack.axis = .vertical
//            verticalStack.spacing = 12
//            verticalStack.alignment = .center
//            verticalStack.distribution = .equalSpacing
//            
//            let imageView = UIImageView(image: badge.image)
//            imageView.backgroundColor = .clear
//            imageView.contentMode = .scaleAspectFit
//            verticalStack.addArrangedSubview(imageView)
//            
//            let label = UILabel()
//            label.font = FontManager.caption2()
//            label.text = badge.concept
//            label.textColor = .gs40
//            label.textAlignment = .center
//            verticalStack.addArrangedSubview(label)
//            
//            horizontalStack.addArrangedSubview(verticalStack)
//        }
//    }
//}
