//
//  MyBookShelfViewModel.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/12/23.
//

import UIKit
import Combine
import Log

protocol MyBookShelfViewRepresentable where Self: UIView {
    func setup(with viewModel: MyBookShelfViewModelRepresentable)
}

protocol MyBookShelfViewModelRepresentable {
    func moveOn(_ to: NextViewType)
}

// MARK: ViewModel
final class MyBookShelfViewModel: MyBookShelfViewModelRepresentable {

    private var cancellables = Set<AnyCancellable>()
    
    var route: AnyPublisher<NextViewType, Never> { self.sendRoute.eraseToAnyPublisher() }
    var sendRoute: PassthroughSubject<NextViewType, Never> = .init()
    
    func moveOn(_ to: NextViewType) {
        sendRoute.send(to)
    }
}
