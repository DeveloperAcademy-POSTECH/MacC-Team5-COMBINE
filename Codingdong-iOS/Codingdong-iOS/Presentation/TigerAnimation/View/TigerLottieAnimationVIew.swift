//
//  TigerLottieAnimationVIew.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/10/23.
//

import Lottie
import UIKit

final class TigerLottieAnimationVIew: UIView {
    private let lottieView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        LottieManager.shared.setAnimation(named: "TigerAnimation", inView: view)
        
        return view
    }()
}
