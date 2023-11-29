//
//  ReviewCollectionViewCell.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/12/23.
//

import UIKit

final class ReviewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ReviewCollectionViewCell"
    
    var cardViewModel: CardViewModel {
        didSet {
            cardView.config(model: cardViewModel)
        }
    }

    // 뷰 선언
    private lazy var cardView: CardView = {
        let view = CardView()
        view.backgroundColor = .gs90
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        self.cardViewModel = .init(title: "", content: "", cardImage: "")
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        self.cardViewModel = .init(title: "", content: "", cardImage: "")
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(cardView)
        cardView.snp.makeConstraints { $0.top.left.right.bottom.equalToSuperview()}
    }
}
