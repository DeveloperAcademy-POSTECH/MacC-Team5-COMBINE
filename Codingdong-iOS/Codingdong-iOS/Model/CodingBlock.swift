//
//  Codingblock.swift
//  Codingdong-iOS
//
//  Created by Joy on 10/21/23.
//

import UIKit

struct CodingBlock: Identifiable, Hashable, Equatable {
    var id = UUID().uuidString
    var value: String
    var isShowing: Bool = false
    var bgColor: UIColor
}

var codingBlocks: [CodingBlock] = [
    CodingBlock(value: "만약에", bgColor: .secondary1),
    CodingBlock(value: "떡이 없다면", bgColor: .secondary2),
    CodingBlock(value: "잡아 먹힌다", bgColor: .secondary2),
    CodingBlock(value: "아니면", bgColor: .secondary1),
    CodingBlock(value: "고개 넘는다", bgColor: .secondary2)
]

var selectBlocks: [CodingBlock] = [
    CodingBlock(value: "떡이 없다면", bgColor: .secondary2),
    CodingBlock(value: "아니면", bgColor: .secondary1),
    CodingBlock(value: "잡아 먹힌다", bgColor: .secondary2),
    CodingBlock(value: "만약에", bgColor: .secondary1),
    CodingBlock(value: "고개 넘는다", bgColor: .secondary2)
]
