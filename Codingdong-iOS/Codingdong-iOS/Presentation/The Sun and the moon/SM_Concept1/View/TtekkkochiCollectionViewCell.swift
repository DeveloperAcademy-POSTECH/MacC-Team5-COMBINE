//
//  TtekkochiCollectionViewCell.swift
//  Codingdong-iOS
//
//  Created by Joy on 10/21/23.
//

import UIKit

final class TtekkkochiCollectionViewCell: UICollectionViewCell {

    static let identifier = "TtekkkochiCollectionViewCell"
    
    var block: CodingBlock {
        didSet {
            nameLabel.text = block.value
            nameLabel.textColor = block.isShowing ? .gs70 : .clear
            nameLabel.backgroundColor = block.isShowing ? block.bgColor : .gs60.withAlphaComponent(0.8)
            nameLabel.isAccessibilityElement = block.isAccessible ? true : false
        }
    }
    
    private let nameLabel: BasePaddingLabel = {
        let label = BasePaddingLabel(padding: UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0))
        label.font = FontManager.p_semiBold(.body)
        label.textAlignment = .center
        label.textColor = .gs70
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 32
        return label
    }()
    
    override init(frame: CGRect) {
        self.block = CodingBlock(value: "", isShowing: false, bgColor: .gs70, isAccessible: true)
        super.init(frame: frame)
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
