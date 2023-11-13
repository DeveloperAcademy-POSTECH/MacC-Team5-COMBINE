//
//  WindowHoleViewController.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 11/6/23.
//

import UIKit

final class WindowHoleViewController: UIViewController, ConfigUI {
    // MARK: - Components
    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "구멍을 탭해서 문 밖에 누가 있는지 확인해주세요."
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
    
    private let tigerHandHoleAnimationView: TigerHandHoleAnimationView = {
        let view = TigerHandHoleAnimationView()
        view.tag = AnimationType.hand.rawValue
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let tigerNoseHoleAnimationView: TigerNoseHoleAnimationView = {
        let view = TigerNoseHoleAnimationView()
        view.tag = AnimationType.nose.rawValue
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let tigerTailHoleAnimationView: TigerTailHoleAnimationView = {
        let view = TigerTailHoleAnimationView()
        view.tag = AnimationType.tail.rawValue
        view.isUserInteractionEnabled = true
        return view
    }()
    
    // MARK: - View init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupNavigationBar()
        addComponents()
        setConstraints()
        setupAccessibility()
        setGestureRecognizer()
    }
    
    func setupNavigationBar() {
        view.addSubview(naviLine)
        naviLine.snp.makeConstraints {
            $0.top.equalToSuperview().offset(106)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.33)
        }
        self.title = "남매의 집에 도착한 호랑이"
        // TODO: 내비 타이틀, 바버튼 각각 보이스 오버 적용되는지 확인
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.gs20, .font: FontManager.navigationtitle()]
        self.navigationController?.navigationBar.tintColor = .gs20
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "books.vertical"),
            style: .plain,
            target: self,
            action: #selector(popThisView)
        )
    }
    
    func addComponents() {
        [titleLabel, windowImageView, tigerHandHoleAnimationView, tigerNoseHoleAnimationView, tigerTailHoleAnimationView].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(naviLine.snp.bottom).offset(Constants.View.padding)
            $0.left.equalToSuperview().offset(Constants.View.padding)
            $0.right.equalToSuperview().offset(-Constants.View.padding)
        }
        
        windowImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(222)
            $0.left.equalToSuperview().offset(51)
            $0.right.equalToSuperview().offset(-51)
            $0.bottom.equalToSuperview().offset(-152)
        }
        
        tigerHandHoleAnimationView.snp.makeConstraints {
            $0.top.equalTo(windowImageView.snp.top).offset(180)
            $0.left.equalTo(windowImageView.snp.left).offset(52)
            $0.right.equalTo(windowImageView.snp.right).offset(-186)
            $0.bottom.equalTo(windowImageView.snp.bottom).offset(-230)
            
        }
        
        tigerNoseHoleAnimationView.snp.makeConstraints {
            $0.top.equalTo(windowImageView.snp.top).offset(84)
            $0.left.equalTo(windowImageView.snp.left).offset(176)
            $0.right.equalTo(windowImageView.snp.right).offset(-48)
            $0.bottom.equalTo(windowImageView.snp.bottom).offset(-332)
        }
        
        tigerTailHoleAnimationView.snp.makeConstraints {
            $0.top.equalTo(windowImageView.snp.top).offset(316)
            $0.left.equalTo(windowImageView.snp.left).offset(153)
            $0.right.equalTo(windowImageView.snp.right).offset(-75)
            $0.bottom.equalTo(windowImageView.snp.bottom).offset(-88)
        }
    }
    
    func setupAccessibility() {
        // TODO: 접근성 적용 확인
    }
    
}

extension WindowHoleViewController {
    enum AnimationType: Int {
        case hand = 1
        case nose = 2
        case tail = 3
    }
    
    @objc func popThisView() {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    func setGestureRecognizer() {
        [tigerHandHoleAnimationView, tigerNoseHoleAnimationView, tigerTailHoleAnimationView].forEach {
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        }
    }
    
    @objc 
    func viewTapped(_ sender: UITapGestureRecognizer) {
        if let type = AnimationType(rawValue: sender.view?.tag ?? 1) {
            switch type {
            case .hand:
                LottieManager.shared.playAnimation(inView: tigerHandHoleAnimationView.lottieView, completion: nil)
            case .nose:
                LottieManager.shared.playAnimation(inView: tigerNoseHoleAnimationView.lottieView, completion: nil)
            case .tail:
                LottieManager.shared.playAnimation(inView: tigerTailHoleAnimationView.lottieView, completion: nil)
            }
        }
    }
}