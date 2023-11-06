//
//  BadgeList.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/11/05.
//

import UIKit

struct Badge: Identifiable, Hashable, Equatable {
    var id = UUID().uuidString
    var title: String
    var theme: String
    var date: Date
    var image: UIImage
    var haveBadge: Bool
}

var dummyBadges: [Badge] = [
    Badge(title: "A2", theme: "조건문", date: Date(), image: UIImage(named: "DummyBadgeA2")!, haveBadge: true),
    Badge(title: "A4", theme: "반복문", date: Date(), image: UIImage(named: "DummyBadgeA4")!, haveBadge: true),
    Badge(title: "B5", theme: "연산자", date: Date(), image: UIImage(named: "DummyBadgeB5")!, haveBadge: true),
    Badge(title: "B3", theme: "함수", date: Date(), image: UIImage(named: "DummyBadgeB3")!, haveBadge: true)
]
