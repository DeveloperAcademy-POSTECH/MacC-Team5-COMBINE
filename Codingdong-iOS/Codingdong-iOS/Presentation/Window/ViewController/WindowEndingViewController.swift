//
//  WindowEndingViewController.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 11/12/23.
//

import UIKit
import SnapKit

final class WindowEndingViewController: UIViewController {
    
    // TODO: isSuccess 값에 따라서 뷰가 바뀌지 않는 문제 해결 필요
    var isSuccess: Int?
    let titleLabelText: [String] = ["어맛, 호랑이에게 잡아먹혔어요. 다시 해볼까요?", "호랑이를 본 오누이는 뒷문으로 도망쳤어요!"]
    let imageName: [String] = ["tigerEatEnding", "initialDoor"]
    let buttonName: [String] = ["다시하기", "다음"]
    
    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = titleLabelText[isSuccess ?? 1]
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName[isSuccess ?? 1])
        return imageView
    }()
    
    private let nextButton = CommonButton()
    private lazy var settingButtonViewModel = CommonbuttonModel(title: buttonName[isSuccess ?? 1], font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .primary2) {[weak self] in
        // TODO: 네비게이션 링크 수정하기
        // 내비게이션 컨트롤은 스택으로 관리 됨. 아마 뷰 6개? 정도 pop하면 될 듯?
        self?.navigationController?.pushViewController(GiveTtekkViewController(), animated: false)
        //        self?.navigationController?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        
        setupNavigationBar()
        addComponents()
        setConstraints()
        nextButton.setup(model: settingButtonViewModel)
    }
    
    func setupNavigationBar() {
        view.addSubview(naviLine)
        naviLine.snp.makeConstraints {
            $0.top.equalToSuperview().offset(106)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.33)
        }
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
}
