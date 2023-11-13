//
//  WindowVoiceViewController.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 11/9/23.
//

import UIKit
import SnapKit
import Log

final class WindowVoiceViewController: UIViewController, ConfigUI {
    
    var mTimer: Timer?
    var initialCountNumber: Int = 3
    var flags = false
    
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "문 밖에 누가 있는지 확인했나요?\n\n문을 열어줄까요?\n\n'열어줄래요', '싫어요' 중에 대답해주세요."
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let doorWithHolesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "doorWithHoles")
        return imageView
    }()
    
    private let speechButton = CommonButton()
    private lazy var speechButtonViewModel = CommonbuttonModel(title: "누르고 말하기", font: FontManager.textbutton(), titleColor: .primary2, backgroundColor: .primary1, didTouchUpInside: nextButtonTapped)
    
    private let countdownBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupAccessibility()
        setupNavigationBar()
        addComponents()
        setConstraints()
        speechButton.setup(model: speechButtonViewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if flags {
            self.navigationController?.pushViewController(WindowEndingViewController(), animated: false)
            Log.i("푸시 이후")
        }
        Log.i("디드 어피어")
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
        [naviLine, titleLabel, doorWithHolesImageView, speechButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(122)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        doorWithHolesImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(324)
            $0.left.equalToSuperview().offset(81)
            $0.right.equalToSuperview().offset(-81)
            $0.bottom.equalToSuperview().offset(-148)
        }
        
        speechButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Constants.Button.buttonPadding)
            $0.right.equalToSuperview().offset(-Constants.Button.buttonPadding)
            $0.bottom.equalToSuperview().offset(-Constants.Button.buttonPadding * 2)
            $0.height.equalTo(72)
        }
    }
    
    func nextButtonTapped() {
        let navigationController = UINavigationController(rootViewController: WindowVoiceChildViewController())
        navigationController.modalPresentationStyle = .overFullScreen
        
        self.present(navigationController, animated: false)
    }
    
    func onTimerStart() {
        if let timer = mTimer {
            if !timer.isValid {
                mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
            }
        }
    }
    
    @objc func timerCallBack() {
        initialCountNumber -= 1
        titleLabel.text = String(initialCountNumber)
    }
    
    func setupAccessibility() {
        navigationItem.accessibilityElements = [leftBarButtonItem, navigationTitle]
        view.accessibilityElements = [titleLabel, speechButton]
        leftBarButtonItem.accessibilityLabel = "내 책장"
    }
    
    @objc
    func popThisView() {
        self.navigationController?.popToRootViewController(animated: false)
    }

}
