//
//  TeachingRepeatViewController.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/14/23.
//

import UIKit
import Log
import Combine

final class TeachingRepeatViewController: UIViewController, ConfigUI {

    // MARK: - Components
    let subject = PassthroughSubject<String, Never>()
    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let leftBarButtonItem: UIBarButtonItem = {
        let leftBarButton = UIBarButtonItem(
            image: UIImage(systemName: "books.vertical"),
            style: .plain,
            target: TeachingRepeatViewController.self,
            action: .none
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
         지금까지 10번 흔들었어요.

         힘든가요?

         반복문을 사용하면, 편하게 반복할 수 있어요!
         """
        label.textColor = .gs10
        label.font = FontManager.body()
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let repeatImage: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "sm_repeat1")
        return imageView
    }()
    
    private let nextButton = CommonButton()
    private lazy var nextButtonViewModel = CommonbuttonModel(title: "다음", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .primary2) {[weak self] in
        Log.t("다음으로 버튼")
    }
    
    // MARK: View init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        addComponents()
        setConstraints()
        setupAccessibility()
        setupUI()
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
        self.navigationItem.hidesBackButton = true
    }
    
    func addComponents() {
        [contentLabel, repeatImage, nextButton].forEach { view.addSubview($0) }

    }
    
    func setConstraints() {
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(naviLine.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        repeatImage.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(60)
            $0.left.equalToSuperview().offset(40)
        }
        
        nextButton.setup(model: nextButtonViewModel)
        nextButton.snp.makeConstraints {
            $0.top.equalTo(repeatImage.snp.bottom).offset(110)
            $0.left.right.equalToSuperview().inset(16)
        }
        [repeatImage, nextButton].forEach{ $0.isHidden = true }
        
    }
    
    func setupAccessibility() {}
    
    func setupUI() {
        // TODO: 나중에 리팩토링 필요 (맘에 안 드는 코드)
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            self.repeatImage.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                self.nextButton.isHidden = false
                self.repeatImage.image = UIImage(named: "sm_repeat2")
            }
            
        }
    }
}
