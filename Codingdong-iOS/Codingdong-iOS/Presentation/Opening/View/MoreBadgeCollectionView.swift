//
//  MoreBadgeCollectionView.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/11/10.
//

import UIKit
import SnapKit

final class MoreBadgeCollectionView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gs80
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var badgeCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.register(MoreBadgeCollectionViewCell.self, forCellWithReuseIdentifier: MoreBadgeCollectionViewCell.identifier)
        view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .clear
        return view
    }()
    
    var sectionData: [[Badge]] = []
    
    private let storyList = ["해님달님","콩쥐팥쥐"]
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        for i in stride(from: 0, to: dummyBadges.count, by: 3) {
            let endIndex = min(i + 3, dummyBadges.count)
            let subArray = Array(dummyBadges[i..<endIndex])
            sectionData.append(subArray)
        }
        
        addSubview(containerView)
        containerView.addSubview(badgeCollectionView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        badgeCollectionView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension MoreBadgeCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoreBadgeCollectionViewCell.identifier, for: indexPath) as? MoreBadgeCollectionViewCell else { fatalError() }
        cell.configure(with: sectionData[indexPath.section], title: storyList[indexPath.section])
        return cell
    }
}

extension MoreBadgeCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 314, height: 174)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 8, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.bounds.width - 20 // 예시로 좌우 각각 10씩 여백을 둡니다.
        let height: CGFloat = 1 // 헤더의 높이를 필요에 따라 조절하세요
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        headerView.backgroundColor = .gs50
        headerView.isHidden = indexPath.section == 0 ? true : false
        return headerView
    }
}
