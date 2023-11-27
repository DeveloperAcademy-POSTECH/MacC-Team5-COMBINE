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
        CodingdongDBService().updateFood(Food(image: "img_yugwa3", concept: "조건문"))
        sendRoute.send(TigerEncountViewController())
    }
}
