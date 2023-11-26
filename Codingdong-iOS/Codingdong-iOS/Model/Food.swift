//
//  Food.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/26/23.
//

import Foundation
import SwiftData

@Model
class FoodList {
    var haveFood: Bool
    var food: [Food]
    
    init(haveFood: Bool, food: [Food]) {
        self.haveFood = haveFood
        self.food = food
    }
}

@Model
final class Food {
    var image: String
    var concept: String
    
    init(image: String, concept: String) {
        self.image = image
        self.concept = concept
    }
}


struct YugwaList {
    var haveYugwa: Bool
    var yugwa: [Yugwa]
}

struct Yugwa {
    var image: String
    var concept: String
}

var yugwaList: YugwaList = YugwaList(haveYugwa: false, yugwa: [])


