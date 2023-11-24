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
    
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let leftBarButton = UIBarButtonItem(
            image: UIImage(systemName: "books.vertical"),
            style: .plain,
            target: self,
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
         오누이는 호랑이를 피하기 위해 동아줄을 붙잡고 올라갔어.

         하지만, 어린 오누이가 올라가기에는 너무 힘든 것 같아.

         오누이가 무사히 올라갈 수 있도록 도와줘!
         """
        label.textColor = .gs10
        label.font = FontManager.body()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let rescueButton = CommonButton()
    private lazy var rescuButtonViewModel = CommonbuttonModel(title: "오누이 구출하기", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .primary2, height: 72) {[weak self] in
        
        self?.navigationController?.pushViewController(RopeViewController(), animated: false)
    }
    
    // MARK: - View Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupNavigationBar()
        addComponents()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAccessibility()
        navigationController?.navigationBar.accessibilityElementsHidden = true
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
            $0.left.right.equalToSuperview().inset(Constants.Button.buttonPadding)
        }
        
        rescueButton.setup(model: rescuButtonViewModel)
        
        rescueButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(Constants.Button.buttonPadding)
            $0.bottom.equalToSuperview().inset(Constants.Button.buttonPadding*2)
        }
    }
    
    func setupAccessibility() {
        let leftBarButtonElement = setupLeftBackButtonItemAccessibility(label: "내 책장")
        let naviTitleElement = setupNavigationTitleAccessibility(label: navigationTitle.text ?? "타이틀 없음")
        view.accessibilityElements = [naviTitleElement, contentLabel, rescueButton, leftBarButtonElement]
    }
    
    @objc func popThisView() {
        self.navigationController?.popToRootViewController(animated: false)
    }
}
