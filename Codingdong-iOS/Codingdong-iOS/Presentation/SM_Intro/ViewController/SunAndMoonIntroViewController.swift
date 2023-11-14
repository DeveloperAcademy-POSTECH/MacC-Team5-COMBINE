//
//  SunAndMoonIntroViewController.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/11/08.
//

import UIKit
import Combine
import Log

final class SunAndMoonIntroViewController: UIViewController, ConfigUI {
    var viewModel = SunAndMoonIntroViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let navigationTitle: UILabel = {
        let label = UILabel()
        label.text = "해님 달님"
        label.font = FontManager.navigationtitle()
        label.textColor = .gs20
        return label
    }()
    
    private let labelComponents = SunAndMoonIntroView()
    
    private let nextButton = CommonButton()
    
    private lazy var nextButtonViewModel = CommonbuttonModel(title: "시작하기", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .gs10, height: 72) {
        self.viewModel.moveOn()
    }
    
    private let basicPadding = Constants.Button.buttonPadding
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupNavigationBar()
        addComponents()
        setConstraints()
        setupAccessibility()
        binding()
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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(popThisView)
        )
    }
    
    func addComponents() {
        [labelComponents, nextButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        labelComponents.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalTo(naviLine).offset(basicPadding)
        }
        
        nextButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(basicPadding)
            $0.right.equalToSuperview().offset(-basicPadding)
            $0.bottom.equalToSuperview().offset(-basicPadding * 2)
        }
    }
    
    func setupAccessibility() {
        self.navigationItem.leftBarButtonItem?.accessibilityLabel = "이전 화면으로 이동"
        view.accessibilityElements = [labelComponents, nextButton]
        
    }

    func binding() {
        nextButton.setup(model: nextButtonViewModel)
        
        self.viewModel.route
            .sink { [weak self] nextView in
                self?.navigationController?.pushViewController(nextView, animated: false)
            }
            .store(in: &cancellable)
    }
    
    @objc
    func popThisView() {
        self.navigationController?.popToRootViewController(animated: false)
    }
}
