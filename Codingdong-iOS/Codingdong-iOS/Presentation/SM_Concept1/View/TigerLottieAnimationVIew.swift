//
//  TigerLottieAnimationVIew.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/10/23.
//

import UIKit
import SnapKit

final class TigerLottieAnimationView: UIView {
    
    lazy var lottieView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        LottieManager.shared.setAnimation(named: "TigerAnimation_HD", inView: view)
        return view
    }()
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lottieView)
        lottieView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
