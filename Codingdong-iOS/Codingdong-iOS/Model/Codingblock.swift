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
}

var codingblocks: [Codingblock] = [
    Codingblock(value: "만약에"),
    Codingblock(value: "떡이 없다면"),
    Codingblock(value: "잡아 먹힌다"),
    Codingblock(value: "아니면"),
    Codingblock(value: "고개 넘는다")
]
