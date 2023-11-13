//
//  WindowEndingViewController.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 11/12/23.
//

import UIKit
import SnapKit

final class WindowEndingViewController: UIViewController, ConfigUI {
    
    // TODO: isSuccess 값에 따라서 뷰가 바뀌지 않는 문제 해결 필요
    var isSuccessInt: Int = 0
    let titleLabelText: [String] = ["어맛, 호랑이에게 잡아먹혔어요. 다시 해볼까요?", "호랑이를 본 오누이는 뒷문으로 도망쳤어요!"]
    let imageName: [String] = ["tigerEatEnding", "initialDoor"]
    let buttonName: [String] = ["다시하기", "다음"]
    
    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let navigationTitle: UILabel = {
        let label = UILabel()
        label.text = "남매의 집에 도착한 호랑이"
        label.font = FontManager.navigationtitle()
        label.textColor = .gs20
        return label
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = titleLabelText[isSuccessInt ?? 1]
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName[isSuccessInt ?? 1])
        return imageView
    }()
    
    private let nextButton = CommonButton()
    private lazy var settingButtonViewModel = CommonbuttonModel(title: buttonName[isSuccessInt ?? 1], font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .primary2) {[weak self] in
        
        // isSuccessInt == 1 - 탈출 성공
        if self?.isSuccessInt == 1 {
            self?.navigationController?.pushViewController(AndConceptViewController(), animated: false)
        } else {
            // isSuccessInt == 0 - 탈출실패
            self?.navigationController?.setViewControllers([MyBookShelfViewController(), WindowStartViewController()], animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupNavigationBar()
        addComponents()
        setConstraints()
        setupAccessibility()
        nextButton.setup(model: settingButtonViewModel)
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
        [titleLabel, imageView, nextButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(122)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(222)
            $0.bottom.equalToSuperview().offset(-152)
            $0.left.equalToSuperview().offset(51)
            $0.right.equalToSuperview().offset(-51)
        }
        
        nextButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Constants.Button.buttonPadding)
            $0.right.equalToSuperview().offset(-Constants.Button.buttonPadding)
            $0.bottom.equalToSuperview().offset(-Constants.Button.buttonPadding * 2)
            $0.height.equalTo(72)
        }
    }
    
    func setupAccessibility() {
        navigationItem.accessibilityElements = [leftBarButtonItem, navigationTitle]
        view.accessibilityElements = [titleLabel, nextButton]
        leftBarButtonItem.accessibilityLabel = "내 책장"
    }
    
    @objc
    func popThisView() {
        self.navigationController?.popToRootViewController(animated: false)
    }
}
