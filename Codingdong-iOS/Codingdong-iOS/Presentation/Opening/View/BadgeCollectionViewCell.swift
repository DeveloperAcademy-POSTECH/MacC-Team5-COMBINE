//
//  BadgeCollectionViewCell.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/11/05.
//

import UIKit

class BadgeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BadgeCollectionViewCell"
    
    private let dateFormatter = DateFormatter()

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var badgeItem: Badge {
        didSet {
            dateFormatter.dateFormat = "yyyy.MM.dd."
            imageView.image = badgeItem.image
            dateLabel.text = dateFormatter.string(from: badgeItem.date)
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.caption2()
        label.textColor = .gs40
        return label
    }()
    
    override init(frame: CGRect) {
        self.badgeItem = Badge(title: "", concept: "", date: Date(), image: UIImage(systemName: "exclamationmark.triangle.fill")!, haveBadge: false, story: "")
        super.init(frame: frame)
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(dateLabel)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.centerX.equalTo(containerView.snp.centerX)
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerX.equalTo(containerView.snp.centerX)
            $0.top.equalTo(imageView.snp.bottom).offset(12)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
