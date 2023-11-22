//
//  Fable.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/11/23.
//

import Foundation
import SwiftData

@Model
class FableData {
    @Attribute(.unique) var title: String
    var isRead: Bool
    
    init(title: String, isRead: Bool) {
        self.title = title
        self.isRead = isRead
    }
}
