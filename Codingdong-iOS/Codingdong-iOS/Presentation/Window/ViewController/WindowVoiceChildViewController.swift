//
//  WindowVoiceChildViewController.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 11/10/23.
//

import UIKit
import SnapKit

final class WindowVoiceChildViewController: UIViewController {
    
    private let containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "3"
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
        
        
    }
//    func addComponents() {
//        containerView.addSubview(titleLabel)
//    }
    
//    func setConstraints() {
//        titleLabel.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
//            $0.top.bottom.equalToSuperview()
//        }
//    }
}
