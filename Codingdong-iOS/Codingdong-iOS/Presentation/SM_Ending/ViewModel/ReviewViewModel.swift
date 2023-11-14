//
//  ReviewViewModel.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/12/23.
//

import UIKit
import Combine
import Log

protocol ReviewViewModelRepresentable {
    func endStory()
}

final class ReviewViewModel: ReviewViewModelRepresentable {
    private var cancellables = Set<AnyCancellable>()
    var route: AnyPublisher<UIViewController, Never> { self.sendRoute.eraseToAnyPublisher() }
    var sendRoute: PassthroughSubject<UIViewController, Never> = .init()
    
    func endStory() {
        yugwaList.haveYugwa = true
        yugwaList.yugwa = [Yugwa(image: "img_yugwa1", concept: "반복문"), Yugwa(image: "img_yugwa2", concept: "연산자"), Yugwa(image: "img_yugwa3", concept: "조건문")]
        // TODO: 해님달님도 읽은 걸로 표시해야 함
    }
}
