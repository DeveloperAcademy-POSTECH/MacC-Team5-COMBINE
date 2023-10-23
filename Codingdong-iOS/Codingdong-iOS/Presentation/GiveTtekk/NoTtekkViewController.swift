//
//  NoTtekkViewController.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 10/23/23.
//

import UIKit
import SnapKit

final class NoTtekkViewController: UIViewController, ConfigUI {

    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "결국 오누이의 엄마는 떡을 다 빼앗겼어요."
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        
        return label
    }()
    
    private let nextButton = CommonButton()
    
    private lazy var nextButtonViewModel = CommonbuttonModel(title: "다음", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .primary2) {[weak self] in
        self?.navigationController?.pushViewController(TigerAnimationViewController(), animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        
        // TODO: NavBar 디자인 component로 나오면 수정하기
        self.navigationController?.navigationBar.topItem?.title = "호랑이를 마주친 엄마"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.gs20, .font: FontManager.p_semiBold(.footnote)]
        setupNavigationBar()
        addComponents()
        setConstraints()
        setupAccessibility()
        nextButton.setup(model: nextButtonViewModel)
    }
    
    func setupNavigationBar() {
        view.addSubview(naviLine)
        naviLine.snp.makeConstraints {
            $0.top.equalToSuperview().offset(106)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.33)
        }
        self.title = "호랑이를 마주친 엄마"
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
        [titleLabel, nextButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(122)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        nextButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Constants.Button.buttonPadding)
            $0.right.equalToSuperview().offset(-Constants.Button.buttonPadding)
            $0.bottom.equalToSuperview().offset(-Constants.Button.buttonPadding * 2)
            $0.height.equalTo(72)
        }
    }
    
    func setupAccessibility(){}
}
