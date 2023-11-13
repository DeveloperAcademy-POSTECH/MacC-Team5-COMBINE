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
        
        //sendRoute.send(MyBookShelfViewController()) // TODO: 루트 바꾸어야 함
        Log.t("홈으로 이동인데 루트를 바꾸어 주어야 함")

    }
}
