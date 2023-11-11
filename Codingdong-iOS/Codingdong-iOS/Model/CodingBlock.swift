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
}

var answerBlocks: [CodingBlock] = [
    CodingBlock(value: "만약에", isShowing: false, bgColor: .secondary1),
    CodingBlock(value: "떡이 없다면", isShowing: false, bgColor: .secondary2),
    CodingBlock(value: "잡아 먹힌다", isShowing: false, bgColor: .secondary2),
    CodingBlock(value: "아니면", isShowing: false, bgColor: .secondary1),
    CodingBlock(value: "고개 넘는다", isShowing: false, bgColor: .secondary2)
]

var selectBlocks: [CodingBlock] = [
    CodingBlock(value: "떡이 없다면", isShowing: true, bgColor: .secondary2),
    CodingBlock(value: "아니면", isShowing: true, bgColor: .secondary1),
    CodingBlock(value: "잡아 먹힌다", isShowing: true, bgColor: .secondary2),
    CodingBlock(value: "만약에", isShowing: true, bgColor: .secondary1),
    CodingBlock(value: "고개 넘는다", isShowing: true, bgColor: .secondary2)
]
