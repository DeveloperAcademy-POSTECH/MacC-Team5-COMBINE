//
//  CustomCollectionViewFlowLayout.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/12/23.
//

import UIKit

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {

    private var previousOffset: CGFloat = 0
    private var currentPage: Int = 0

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }

        let itemsCount = collectionView.numberOfItems(inSection: 0)
        
        // 이전의 offset을 체크한 후, 스크롤 방향을 결정
        if previousOffset > collectionView.contentOffset.x && velocity.x < 0 {
            currentPage = max(currentPage - 1, 0)
        } else if previousOffset < collectionView.contentOffset.x && velocity.x > 0 {
            currentPage = min(currentPage + 1, itemsCount - 1)
        }
        
        // 오프셋 업데이트 
        let updatedOffset = (itemSize.width + minimumInteritemSpacing) * CGFloat(currentPage)
        previousOffset = updatedOffset

        return CGPoint(x: updatedOffset, y: proposedContentOffset.y)
    }
}
