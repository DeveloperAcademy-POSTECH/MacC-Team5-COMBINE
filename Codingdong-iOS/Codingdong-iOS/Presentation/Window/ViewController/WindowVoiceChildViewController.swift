//
//  WindowVoiceChildViewController.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 11/10/23.
//

import UIKit
import SnapKit
import Log

final class WindowVoiceChildViewController: UIViewController {
    
    var mTimer: Timer?
    var initialCountNumber: Int = 3
    
    private let containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = String(initialCountNumber)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontManager.p_Bold(FontSize(rawValue: 64) ?? .largetitle)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        Log.t("View Did Load")
        onTimerStart()
    }
    
    func onTimerStart() {
        if let timer = mTimer {
            if !timer.isValid {
                mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
            }
        } else {
            mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
        }
    }
    
    func onTimerEnd() {
        if let timer = mTimer {
            if initialCountNumber == 0 {
                timer.invalidate()
                // TODO: STT 실행
                Log.t("Timer invalidate")
                Log.t("\(initialCountNumber)")
            }
        }
    }
    
    @objc func timerCallBack() {
        initialCountNumber -= 1
        if initialCountNumber == 0 {
            onTimerEnd()
        }
        Log.t("\(initialCountNumber)")
        titleLabel.text = String(initialCountNumber)
    }
}
