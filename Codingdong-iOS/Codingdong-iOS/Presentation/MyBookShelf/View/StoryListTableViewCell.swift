//
//  StoryListTableViewCell.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/11/05.
//

import UIKit

final class StoryListTableViewCell: UITableViewCell {
    
    static let identifier = "StoryListTableViewCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gs80
        
        return view
    }()
    
    var storyTitle: StoryTitle {
        didSet {
            isReadSymbolImage.image = storyTitle.isRead ? UIImage(systemName: "play.square") : UIImage(systemName: "lock.fill")
            titleLabel.text = storyTitle.title
            isReadChevronImage.isHidden = storyTitle.isRead ? false : true
        }
    }
    
    private let isReadSymbolImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .secondary1
//        imageView.layer.borderWidth = 1
//        imageView.layer.borderColor = UIColor.white.cgColor
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.caption1()
        label.textColor = .white
        label.backgroundColor = .gs80
//        label.layer.borderWidth = 1
//        label.layer.borderColor = UIColor.white.cgColor

        return label
    }()
    
    private let isReadChevronImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gs30
        imageView.image = UIImage(systemName: "chevron.right")
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.storyTitle = StoryTitle(title: "", isRead: false)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(containerView)
        containerView.addSubview(isReadSymbolImage)
        containerView.addSubview(titleLabel)
        containerView.addSubview(isReadChevronImage)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        isReadSymbolImage.snp.makeConstraints {
            $0.centerY.equalTo(containerView.snp.centerY)
            $0.left.equalToSuperview().offset(25)
            $0.height.equalTo(25)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(containerView.snp.centerY)
            $0.left.equalTo(isReadSymbolImage.snp.right).offset(14)
        }
        
        isReadChevronImage.snp.makeConstraints {
            $0.centerY.equalTo(containerView.snp.centerY)
            $0.right.equalToSuperview().offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func configure(with model: StoryTitle) {
//        titleLabel.text = model.title
//        isReadSymbolImage.image = storyTitle.isRead ? UIImage(systemName: "play.square") : UIImage(systemName: "lock.fill")
//        isReadChevronImage.isHidden = storyTitle.isRead ? false : true
//    }
}
