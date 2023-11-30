//
//  Codingblock.swift
//  Codingdong-iOS
//
//  Created by Joy on 10/21/23.

import UIKit

struct CodingBlock {
    var value: String
    var isShowing: Bool
    var bgColor: UIColor
    var isAccessible: Bool
}

var answerBlocks: [CodingBlock] = [
    CodingBlock(value: "만약에", isShowing: false, bgColor: .secondary1, isAccessible: true),
    CodingBlock(value: "떡 하나 주면", isShowing: false, bgColor: .secondary2, isAccessible: true),
    CodingBlock(value: "안 잡아먹는다", isShowing: false, bgColor: .secondary2, isAccessible: true),
    CodingBlock(value: "아니면", isShowing: false, bgColor: .secondary1, isAccessible: true),
    CodingBlock(value: "잡아먹는다", isShowing: false, bgColor: .secondary2, isAccessible: true)
]

var selectBlocks: [CodingBlock] = [
    CodingBlock(value: "잡아먹는다", isShowing: true, bgColor: .secondary2, isAccessible: true),
    CodingBlock(value: "아니면", isShowing: true, bgColor: .secondary1, isAccessible: true),
    CodingBlock(value: "안 잡아먹는다", isShowing: true, bgColor: .secondary2, isAccessible: true),
    CodingBlock(value: "만약에", isShowing: true, bgColor: .secondary1, isAccessible: true),
    CodingBlock(value: "떡 하나 주면", isShowing: true, bgColor: .secondary2, isAccessible: true)
]
