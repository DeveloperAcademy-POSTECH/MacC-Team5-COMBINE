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
    var concept: String
    var date: Date
    var image: UIImage
    var haveBadge: Bool
    var story: String
}

var dummyBadges: [Badge] = [
    Badge(title: "A1", concept: "조건문", date: Date(), image: UIImage(named: "DummyA1")!, haveBadge: true, story: "해님달님"),
    Badge(title: "A2", concept: "연산자", date: Date(), image: UIImage(named: "DummyA1")!, haveBadge: true, story: "해님달님"),
    Badge(title: "A3", concept: "반복문", date: Date(), image: UIImage(named: "DummyA3")!, haveBadge: true, story: "해님달님"),
    Badge(title: "B3", concept: "함수", date: Date(), image: UIImage(named: "DummyA3")!, haveBadge: true, story: "콩쥐팥쥐"),
    Badge(title: "B3", concept: "함수", date: Date(), image: UIImage(named: "DummyA3")!, haveBadge: true, story: "콩쥐팥쥐"),
    Badge(title: "B3", concept: "함수", date: Date(), image: UIImage(named: "DummyA3")!, haveBadge: true, story: "콩쥐팥쥐")
]
