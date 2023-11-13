//
//  TigerTailHoleAnimationView.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 11/11/23.
//

import UIKit
import SnapKit

final class TigerTailHoleAnimationView: UIView {
    
    lazy var tailLottieView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        LottieManager.shared.setAnimation(named: "TigerTailHoleAnimation", inView: view)
        return view
    }()
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tailLottieView)
        tailLottieView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
