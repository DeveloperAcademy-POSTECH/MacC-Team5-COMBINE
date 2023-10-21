//
//  Codingblock.swift
//  Codingdong-iOS
//
//  Created by Joy on 10/21/23.
//

import UIKit

struct Codingblock: Identifiable, Hashable, Equatable {
    var id = UUID().uuidString
    var value: String
    var isShowing: Bool = false
    var bgColor: UIColor
}

var codingblocks: [Codingblock] = [
    Codingblock(value: "만약에", bgColor: .secondary1),
    Codingblock(value: "떡이 없다면", bgColor: .secondary2),
    Codingblock(value: "잡아 먹힌다", bgColor: .secondary2),
    Codingblock(value: "아니면", bgColor: .secondary1),
    Codingblock(value: "고개 넘는다", bgColor: .secondary2)
]
