//
//  OnboardingViewModel.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/11/23.
//

import UIKit
import Combine

protocol OnboardViewRepresentable where Self: UIView {
    func setup(with viewModel: OnboardingViewModel)
}

protocol OnboardingViewRepresentable {
    func tapNextButton()
}

final class OnboardingViewModel: OnboardingViewRepresentable {
 
    private var cancellables = Set<AnyCancellable>()
    
    var route: AnyPublisher<UIViewController, Never> {
        self.sendRoute.eraseToAnyPublisher()
    }
    
    var sendRoute: PassthroughSubject<UIViewController, Never> = .init()
    
    func tapNextButton() {
        sendRoute.send(MyBookShelfViewController())
    }
}
