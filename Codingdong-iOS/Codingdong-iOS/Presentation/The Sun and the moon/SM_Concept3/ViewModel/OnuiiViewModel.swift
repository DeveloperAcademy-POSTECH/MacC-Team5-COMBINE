//
//  OnuiiViewModel.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/13/23.
//

import UIKit
import Combine
import Log

protocol OnuiiViewModelRepresentable {
    func moveOn()
}

final class OnuiiViewModel: OnuiiViewModelRepresentable {
    var route: AnyPublisher<UIViewController, Never> {
        self.sendRoute.eraseToAnyPublisher()
    }
    var sendRoute: PassthroughSubject<UIViewController, Never> = .init()
    
    func moveOn() {
        Log.i("다음으로 버튼이 클릭됨")
    }
}
