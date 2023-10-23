//
//  TigerAnimationViewController.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/10/23.
//

import UIKit

final class TigerAnimationViewController: UIViewController {
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "떡을 모두 빼앗긴 엄마는 호랑이에게 잡아먹히고 말았어요."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontManager.p_Regular(.body)
        label.textColor = .gs10
        label.numberOfLines = 0
        
        return label
    }()
    
    private let animationView = TigerLottieAnimationVIew()
    
    private var btnBottomConstraints: NSLayoutConstraint? = nil
    
    // TODO: 조부장님 이거 이렇게 쓰는거 맞나요?
    private let nextButton = CommonButton()
    
    private lazy var nextButtonViewModel = CommonbuttonModel(title: "다음", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .primary2, height: 72, didTouchUpInside: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        
        // TODO: NavBar 디자인 component로 나오면 수정하기
        self.navigationController?.navigationBar.topItem?.title = "호랑이를 마주친 엄마"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.gs20, .font: FontManager.p_semiBold(.footnote)]
        
        addComponents()
        setConstraints()
        
        // TODO: 조부장님께 CommonButton 사용법 여쭙고 버튼 추가하기
        nextButton.setup(model: nextButtonViewModel)
        
        // TODO: titleLabel을 읽고 실행하도록 수정해야함.
        LottieManager.shared.playAnimation(inView: animationView) { (finished) in
            if finished { self.bottomBtnSpringAnimation() }
        }
        
    }
    
    func addComponents() {
        [titleLabel, animationView, nextButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(122)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        animationView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0)
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(0)
        }
        
        btnBottomConstraints = nextButton.bottomAnchor.constraint(equalTo: super.view.bottomAnchor, constant: 72)
        guard let bottomConstraints = btnBottomConstraints else { return }
        bottomConstraints.isActive = true
        
        nextButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Constants.Button.buttonPadding)
            $0.right.equalToSuperview().offset(-Constants.Button.buttonPadding)
        }
    }
}

extension TigerAnimationViewController {
    
    private func bottomBtnSpringAnimation() {
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.4,
                       options: []) { [weak self] in
            guard let self = self else { return }
            
            // TODO: CustomButton 사용법 조부장님께 확인 받고 bottomConstraints 지정하기
            self.btnBottomConstraints?.constant = -Constants.Button.buttonPadding * 2
            self.view.layoutIfNeeded()
        } completion: { _ in
            
        }
    }
    
    @objc func didClickNextButton() {
        // TODO: 다음 화면으로 내비게이션 연결 추가해야함.
        LottieManager.shared.removeAnimation(inView: animationView)
    }
}
