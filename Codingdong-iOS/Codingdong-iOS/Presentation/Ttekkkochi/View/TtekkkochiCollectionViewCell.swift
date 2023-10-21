//
//  TtekkochiCollectionViewCell.swift
//  Codingdong-iOS
//
//  Created by Joy on 10/21/23.
//

import UIKit

enum CellState {
    case selected
    case unselected
}

final class TtekkkochiCollectionViewCell: UICollectionViewCell {

    static let identifier = "TtekkochiCollectionViewCell"
    
    var block: CodingBlock {
        didSet {
            nameLabel.text = block.value
        }
    }
    
    private let nameLabel: BasePaddingLabel = {
        let label = BasePaddingLabel(padding: UIEdgeInsets(top: 15.0, left: 36.0, bottom: 15.0, right: 36.0))
        label.font = FontManager.p_semiBold(.body)
        label.textAlignment = .center
        label.textColor = .gs70
        label.backgroundColor = .secondary1
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 32
        return label
    }()
    
    override init(frame: CGRect) {
        self.block = CodingBlock(value: "", bgColor: .gs70)
        super.init(frame: frame)
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(_ type: CellState) {
        switch type {
        case .selected:
            nameLabel.backgroundColor = block.bgColor
            nameLabel.text = block.value
        case .unselected:
            nameLabel.backgroundColor = .gs70
        }
    }
}
