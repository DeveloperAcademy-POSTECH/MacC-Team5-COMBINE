//
//  WindowEndingViewController.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 11/12/23.
//

import UIKit
import SnapKit

final class WindowEndingViewController: UIViewController, ConfigUI {
    
    private var isSuccessInt = UserDefaults.standard.integer(forKey: "key")
    let titleLabelText: [String] = [
        """
        아앗, 오누이가 호랑이한테 잡아먹히고 말았어.
        다시 해 볼까?
        """,
        """
        잘했어! 정답이야!
        호랑이를 본 오누이는 무사히 뒷문으로 도망쳤어!
        """]
    let imageName: [String] = ["tigerEatEnding", "initialDoor"]
    let buttonName: [String] = ["다시하기", "다음으로"]
    
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
        label.text = titleLabelText[isSuccessInt]
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName[isSuccessInt])
        return imageView
    }()
    
    private let nextButton = CommonButton()
    private lazy var settingButtonViewModel = CommonbuttonModel(title: buttonName[isSuccessInt], font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .primary2, height: 72) {[weak self] in
        if self?.isSuccessInt == 1 {
            self?.navigationController?.pushViewController(AndConceptViewController(), animated: false)
        } else {
            guard let viewControllerStack = self?.navigationController?.viewControllers else { return }
            for viewController in viewControllerStack {
                if let startView = viewController as? WindowVoiceViewController {
                    self?.navigationController?.popToViewController(startView, animated: true)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
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
        [titleLabel, imageView, nextButton].forEach {
            view.addSubview($0)
        }
        nextButton.setup(model: settingButtonViewModel)
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(naviLine.snp.bottom).offset(Constants.View.padding)
            $0.left.right.equalToSuperview().inset(Constants.View.padding)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(256)
            $0.left.right.equalToSuperview().inset(51)
            $0.bottom.equalToSuperview().inset(118)
        }
        
        nextButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(Constants.Button.buttonPadding)
            $0.bottom.equalToSuperview().inset(Constants.Button.buttonPadding * 2)
        }
    }
    
    func setupAccessibility() {
        let leftBarButtonElement = setupLeftBackButtonItemAccessibility(label: "내 책장")
        view.accessibilityElements = [titleLabel, nextButton, leftBarButtonElement]
    }
    
    @objc
    func popThisView() {
        self.navigationController?.popToRootViewController(animated: false)
    }
}
