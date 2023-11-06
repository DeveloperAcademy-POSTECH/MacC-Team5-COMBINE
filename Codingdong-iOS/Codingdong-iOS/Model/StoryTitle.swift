//
//  StoryList.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/11/05.
//

import UIKit

struct StoryTitle: Identifiable, Hashable, Equatable {
    var id = UUID().uuidString
    var title: String
    var isRead: Bool
}

var storyList: [StoryTitle] = [
    StoryTitle(title: "해님달님", isRead: true),
    StoryTitle(title: "콩쥐팥쥐", isRead: false),
    StoryTitle(title: "별주부전", isRead: false)
]
