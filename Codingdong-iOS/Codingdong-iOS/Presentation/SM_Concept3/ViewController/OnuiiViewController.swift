//
//  OnuiiViewController.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/13/23.
//

import UIKit
import Combine
import Log

final class OnuiiViewController: UIViewController, ConfigUI {
 
    private var viewModel = TtekkkochiViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Components
    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let leftBarButtonItem: UIBarButtonItem = {
        let leftBarButton = UIBarButtonItem(
            image: UIImage(systemName: "books.vertical"),
            style: .plain,
            target: OnuiiViewController.self,
            action: #selector(popThisView)
        )
        return leftBarButton
    }()
    
    private let navigationTitle: UILabel = {
       let label = UILabel()
        label.text = "동아줄을 잡은 남매와 호랑이"
        label.font = FontManager.navigationtitle()
        label.textColor = .gs20
        return label
    }()
    
    private let contentLabel: UILabel = {
       let label = UILabel()
        label.text = """
         오누이는 호랑이를 피하기 위해 동아줄을 붙잡고 올라갔어요.

         하지만, 어린 오누이는 동아줄을 잡고 올라가기가 너무 힘들었어요.

         오누이가 무사히 올라갈 수 있도록 도와주세요!
         """
        label.textColor = .gs10
        label.font = FontManager.body()
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let rescueButton = CommonButton()
    private lazy var rescuButtonViewModel = CommonbuttonModel(title: "오누이 구출하기", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .primary2) {[weak self] in
        self?.viewModel.selectItem()
    }
    
    // MARK: - View Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        addComponents()
        setConstraints()
        setupAccessibility()
    }
    
    func setupNavigationBar() {
        view.addSubview(naviLine)
        naviLine.snp.makeConstraints {
            $0.top.equalToSuperview().offset(106)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.33)
        }
        self.navigationController?.navigationBar.tintColor = .gs20
        self.navigationItem.titleView = self.navigationTitle
        self.navigationItem.leftBarButtonItem = self.leftBarButtonItem
    }
    
    func addComponents() {
        [contentLabel, rescueButton].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(naviLine.snp.bottom).offset(Constants.Button.buttonPadding)
            $0.left.equalToSuperview().offset(Constants.Button.buttonPadding)
            $0.right.equalToSuperview().offset(-Constants.Button.buttonPadding)
        }
        
        rescueButton.setup(model: rescuButtonViewModel)
        
        rescueButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-Constants.Button.buttonPadding*2)
        }
    }
    
    func setupAccessibility() {
        
    }
}

extension OnuiiViewController {
    @objc private func popThisView() {
        Log.i("홈화면으로 이동")
        //self.navigationController?.popToRootViewController(animated: false)
    }
}
