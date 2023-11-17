//
//  LottieManager.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/10/23.
//

import UIKit
import Lottie

class LottieManager {
    static let shared = LottieManager()
    private var animationViews: [UIView: LottieAnimationView] = [:]
    
    private init() { }

    func setAnimation(named animationName: String, inView view: UIView) {
        let animationView = LottieAnimationView(name: animationName)
        view.addSubview(animationView)
        animationViews[view] = animationView
    }

    func setAnimationForOnui(named animationName: String, inView view: UIView) {
        let animationView = LottieAnimationView(name: animationName)
        view.addSubview(animationView)
        animationView.snp.makeConstraints {
            $0.width.height.equalToSuperview().multipliedBy(1)
            $0.center.equalToSuperview()
        }
        animationViews[view] = animationView
    }

    func setAnimationForWindow(named animationName: String, inView view: UIView) {
        let animationView = LottieAnimationView(name: animationName)
        animationView.contentMode = .scaleAspectFill
        view.addSubview(animationView)
        animationView.snp.makeConstraints {
            $0.width.height.equalToSuperview().multipliedBy(2.826)
            $0.center.equalToSuperview()
        }
        animationViews[view] = animationView
    }
    
    func playAnimation(inView view: UIView, completion: ((Bool) -> Void)?) {
        if let animationView = animationViews[view] {
            animationView.play(completion: completion)
        }
    }
    
    func playWithProgressTimeAnimation(inView view: UIView, completion: ((Bool) -> Void)?) {
        if let animationView = animationViews[view] {
            animationView.play(fromProgress: 0, toProgress: 0.5)
        }
    }
    
    
    func stopAnimation(inView view: UIView) {
        if let animationView = animationViews[view] {
            animationView.stop()
        }
    }
    
    func removeAnimation(inView view: UIView) {
        if animationViews[view] != nil {
            animationViews.removeValue(forKey: view)
        }
    }
}
