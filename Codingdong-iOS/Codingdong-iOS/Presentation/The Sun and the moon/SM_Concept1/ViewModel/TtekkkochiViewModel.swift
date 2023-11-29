//
//  TtekkkochiViewModel.swift
//  Codingdong-iOS
//
//  Created by Joy on 10/22/23.
//

import UIKit
import Combine
import Log

// MARK: - Protocol
protocol TtekkkochiViewRepresentable where Self: UIView {
    func setup(with viewModel: TtekkkochiViewModelRepresentable)
}

protocol TtekkkochiViewModelRepresentable {
    func selectItem()
}

// MARK: - Class
final class TtekkkochiViewModel: TtekkkochiViewModelRepresentable {
    private var cancellables = Set<AnyCancellable>()
    
    var route: AnyPublisher<UIViewController, Never> {
        self.sendRoute.eraseToAnyPublisher()
    }
    var sendRoute: PassthroughSubject<UIViewController, Never> = .init()
    
    func selectItem() {
        Log.i("다음으로 버튼이 클릭됨")
        sendRoute.send(GiveTtekkViewController())
    }

}
