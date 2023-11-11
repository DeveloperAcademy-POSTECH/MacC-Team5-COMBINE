//
//  CookieList.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/11/23.
//

import Foundation

struct YugwaList {
    var haveYugwa: Bool
    var yugwa: [Yugwa]
}

struct Yugwa {
    var image: String
    var concept: String
}

var cookieList: YugwaList = YugwaList(haveYugwa: false, yugwa: [])
