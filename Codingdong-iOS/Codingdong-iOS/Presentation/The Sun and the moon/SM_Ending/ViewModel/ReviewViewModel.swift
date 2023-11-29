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
        CddDBService().updateFable(FableData(title: "콩쥐팥쥐", isRead: true))
    }
}
