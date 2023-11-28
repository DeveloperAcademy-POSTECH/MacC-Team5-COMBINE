//
//  SunAndMoonIntroViewModel.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/12/23.
//

import UIKit
import Combine

protocol SunAndMoonIntroViewModelRepresentable {
    func moveOn()
}

final class SunAndMoonIntroViewModel: SunAndMoonIntroViewModelRepresentable {
    private var cancellables = Set<AnyCancellable>()
    
    var route: AnyPublisher<UIViewController, Never> { self.sendRoute.eraseToAnyPublisher() }
    var sendRoute: PassthroughSubject<UIViewController, Never> = .init()
    
    func moveOn() {
        // TODO: 위치 옮기기(조건문 학습 이후로), 지금 여러 개 들어감, 데이터 로드 시점 바꾸기
        CddDBService().updateFood(Food(image: "img_yugwa3", concept: "조건문"))
        sendRoute.send(TigerEncountViewController())
    }
}
