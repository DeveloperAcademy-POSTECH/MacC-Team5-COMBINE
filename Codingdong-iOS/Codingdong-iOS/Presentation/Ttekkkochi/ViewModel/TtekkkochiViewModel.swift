//
//  TtekkkochiViewModel.swift
//  Codingdong-iOS
//
//  Created by Joy on 10/21/23.
//

import UIKit
import Combine

// MARK: - Protocol
protocol TtekkkochiViewRepresentable where Self: UIView {
    func setup(with viewModel: TtekkkochiViewModel)
}

protocol TtekkkochiViewModelRepresentable {
    func selectItem()
}

// MARK: - Class
final class TtekkkochiViewModel {
    @Published var blockValue: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func selectItem() {
        print("친구 추가")
    }
}
