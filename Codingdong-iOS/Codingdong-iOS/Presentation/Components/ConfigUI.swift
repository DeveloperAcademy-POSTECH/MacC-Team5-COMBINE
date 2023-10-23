//
//  ConfigUI.swift
//  Codingdong-iOS
//
//  Created by Joy on 10/19/23.
//

import Foundation
import UIKit

protocol ConfigUI {
    /// 네비게이션 바 설정
    func setupNavigationBar()
    
    /// 컴포넌트를 추가
    func addComponents()
    
    /// 위치 설정
    func setConstraints()
}
