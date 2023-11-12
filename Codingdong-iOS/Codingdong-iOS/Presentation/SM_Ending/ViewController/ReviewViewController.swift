//
//  ReviewViewController.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/12/23.
//

import UIKit
import Log

final class ReviewViewController: UIViewController, ConfigUI {
    
    // 뷰 전체 model, cellModel
    // MARK: - ViewModel
    var cellModels: [CardViewModel] = [.init(title: "만약에 : 조건문", content: "만약에는 코딩의 ‘조건문’에 해당돼요. 조건문은 정해진 상황에 따라 다른 동작이 수행되게 만들 수 있어요.", cardImage: "sm_review1"),
        .init(title: "그리고 : 연산자", content: "그리고는 코딩의 ‘연산자’에 해당돼요. 연산자는 조건의 ‘참'과 ‘거짓'을 판단해요.", cardImage: "sm_review2"),
        .init(title: "거듭하기 : 반복문", content: "거듭하기는 코딩의 ‘반복문’에 해당돼요. 반복문을 사용하여 같은 동작이 반복되도록 만들 수 있어요.", cardImage: "sm_review3")]
    
    // MARK: - Components
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "해님달님에서 세 가지 개념을 배웠어요"
        label.textColor = .gs10
        label.numberOfLines = 0
        label.font = FontManager.body()
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private lazy var reviewCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: ReviewCollectionViewCell.identifier)
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gs90
        return view
    }()

    private let padding = Constants.View.padding
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        addComponents()
        setConstraints()
    }
    
    func setupNavigationBar() {}
    
    func addComponents() {
        [contentLabel, reviewCollectionView].forEach { view.addSubview($0) }
        
        let collectionViewFlowLayout: UICollectionViewFlowLayout = {
            let layout = CustomCollectionViewFlowLayout()
            layout.itemSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height - 348)
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.scrollDirection = .horizontal
            return layout
        }()
        
        reviewCollectionView.collectionViewLayout = collectionViewFlowLayout
        reviewCollectionView.decelerationRate = .fast
        reviewCollectionView.isPagingEnabled = false

    }
    
    func setConstraints() {
        contentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.left.equalToSuperview().offset(padding)
            $0.right.equalToSuperview().offset(-padding)
        }
        
        reviewCollectionView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(padding)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-142)
        }
    }
    
    func setupAccessibility() {}
}

// MARK: - Extension
extension ReviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.identifier, for: indexPath) as? ReviewCollectionViewCell else { fatalError() }
        cell.cardViewModel = cellModels[indexPath.row]
        return cell
    }
}
