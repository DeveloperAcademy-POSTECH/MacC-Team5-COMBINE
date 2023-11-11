//
//  YugwaCell.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/11/23.
//

import UIKit

final class YugwaCell: UICollectionViewCell {
    
    static let identifier = "YugwaCell"
    
    private var model: Yugwa {
        didSet {
            yugwaImage.image = UIImage(named: model.image)
            conceptLabel.text = model.concept
        }
    }
    
    // MARK: - Components
    private let yugwaImage: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let conceptLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.caption2()
        label.textColor = .gs40
        return label
    }()
    
    private lazy var containerView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: - Intializer
    override init(frame: CGRect) {
        self.model = Yugwa(image: "", concept: "")
        super.init(frame: frame)
        addSubview(containerView)
        containerView.snp.makeConstraints { $0.left.right.top.bottom.equalToSuperview() }
        [yugwaImage, conceptLabel].forEach { containerView.addArrangedSubview($0)}
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
