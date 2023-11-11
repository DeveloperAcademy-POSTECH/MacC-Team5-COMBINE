//
//  WindowHoleViewController.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 11/6/23.
//

import UIKit
import SnapKit

final class WindowHoleViewController: UIViewController {
    // MARK: - Components
    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "구멍을 탭해서 문 밖에 누가 있는지 확인해주세요."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let windowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "initialDoor")
        return imageView
    }()
    
    private let tigerHandHoleAnimationView = TigerHandHoleAnimationView()
    private let tigerNoseHoleAnimationView = TigerNoseHoleAnimationView()
    private let tigerTailHoleAnimationView = TigerTailHoleAnimationView()
    
    // MARK: - View init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupNavigationBar()
        addComponents()
        setConstraints()
        
        // TODO: lottie view 탭 제스처 코드
        // TODO: 탭 제스처가 인식이 안되는 문제 해결
        self.tigerHandHoleAnimationView.isUserInteractionEnabled = true
        self.tigerHandHoleAnimationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
    }
    
    func setupNavigationBar() {
        view.addSubview(naviLine)
        self.title = "남매의 집에 도착한 호랑이"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.gs20, .font: FontManager.navigationtitle()]
        self.navigationController?.navigationBar.tintColor = .gs20
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "books.vertical"),
            style: .plain,
            target: self,
            action: .none
        )
    }
    
    func addComponents() {
        [titleLabel, windowImageView, tigerHandHoleAnimationView, tigerNoseHoleAnimationView, tigerTailHoleAnimationView].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        naviLine.snp.makeConstraints {
            $0.top.equalToSuperview().offset(106)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.33)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(122)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        windowImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(51)
            $0.right.equalToSuperview().offset(-51)
            $0.top.equalToSuperview().offset(214)
            $0.bottom.equalToSuperview().offset(-160)
        }
        
        tigerHandHoleAnimationView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(74)
            $0.top.equalToSuperview().offset(326)
        }
        
        tigerNoseHoleAnimationView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(164)
            $0.top.equalToSuperview().offset(285)
        }
        
        tigerTailHoleAnimationView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(170)
            $0.top.equalToSuperview().offset(490)
        }
    }
    
    @objc func viewTapped() {
        LottieManager.shared.playAnimation(inView: tigerHandHoleAnimationView.handLottieView, completion: nil)
    }
}
