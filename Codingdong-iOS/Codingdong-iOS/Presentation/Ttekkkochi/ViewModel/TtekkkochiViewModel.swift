//
//  TtekkkochiViewModel.swift
//  Codingdong-iOS
//
//  Created by Joy on 10/22/23.
//

import UIKit
import Combine

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
    
    func selectItem() {
        Logger().info("다음으로 버튼이 클릭됨")
    }
}
