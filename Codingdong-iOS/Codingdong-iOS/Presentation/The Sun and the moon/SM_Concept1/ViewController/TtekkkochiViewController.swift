//
//  TtekkkochiViewController.swift
//  Codingdong-iOS
//
//  Created by Joy on 10/20/23.
//

import UIKit
import Combine
import Log

final class TtekkkochiViewController: UIViewController, ConfigUI {
    var viewModel = TtekkkochiViewModel()
    private var cancellable = Set<AnyCancellable>()
    private var blockIndex: Int = 0
    private var hapticManager: HapticManager?
    
    // MARK: - Components
    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let navigationTitle: UILabel = {
        let label = UILabel()
        label.text = "호랑이를 마주친 엄마"
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
        label.text = "화면 아래쪽에 노오란 떡들이 놓여져 있어. 아래로 가볼까?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let stickView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var ttekkkochiCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.register(TtekkkochiCollectionViewCell.self, forCellWithReuseIdentifier: TtekkkochiCollectionViewCell.identifier)
        view.isAccessibilityElement = false
        view.backgroundColor = .clear
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private let bottomView = TtekkkochiSelectionView()
    
    private let nextButton = CommonButton()
    private lazy var settingButtonViewModel = CommonbuttonModel(title: "꼬치를 준다", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .primary2) {[weak self] in
       self?.viewModel.selectItem()
    }

    private let ttekkkochiCollectionViewElement: UIAccessibilityElement = {
        let element = UIAccessibilityElement(accessibilityContainer: TtekkkochiViewController.self)
        element.accessibilityLabel = "조금만 더 아래로 가면 돼! '만약에' 떡과, '아니면' 떡을 활용해 순서에 맞게 끼워보렴"
        return element
    }()
    
    // MARK: - View init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupNavigationBar()
        addComponents()
        setConstraints()
        nextButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        binding()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        navigationController?.navigationBar.accessibilityElementsHidden = true
    }
    
    func addComponents() {
        [titleLabel, ttekkkochiCollectionView, bottomView, nextButton, stickView].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(naviLine.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        ttekkkochiCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.left.right.equalToSuperview().inset(95)
            $0.bottom.equalTo(bottomView.snp.top).offset(-122)
        }
        
        stickView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.left.right.equalToSuperview().inset(191)
            $0.bottom.equalTo(bottomView.snp.top).offset(-72)
        }
        
        self.view.sendSubviewToBack(stickView)
        
        bottomView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(Constants.Button.buttonPadding)
            $0.bottom.equalToSuperview().inset(Constants.Button.buttonPadding * 2)
            $0.height.equalTo(112)
        }
        
        nextButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(Constants.Button.buttonPadding)
            $0.bottom.equalToSuperview().inset(Constants.Button.buttonPadding * 2)
            $0.height.equalTo(72)
        }
    }
    
    func setupAccessibility() {
        let leftBarButtonElement = setupLeftBackButtonItemAccessibility(label: "내 책장")
        ttekkkochiCollectionViewElement.accessibilityFrameInContainerSpace = ttekkkochiCollectionView.frame
        view.accessibilityElements = [titleLabel, ttekkkochiCollectionViewElement, bottomView, nextButton, leftBarButtonElement]
    }
    
    func binding() {
        self.bottomView.setup(with: viewModel)
        self.viewModel.route
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] nextView in
                for index in (0...4) { answerBlocks[index].isShowing = false }
                self?.navigationController?.pushViewController(nextView, animated: false)
            })
            .store(in: &cancellable)
    
        self.bottomView.$selectedValue
            .zip(bottomView.$initialValue)
            .sink { [weak self] value in
                guard let index = self?.blockIndex else { return }
                guard value.1 else { return }
                guard let self = self else { return }
        
                if (index > -1 && index < 5) && (answerBlocks[index].value == value.0) {
                    answerBlocks[index].isShowing = true
                    DispatchQueue.global().async {
                        SoundManager.shared.playSound(sound: .bell)
                    }

                    for idx in (0...4) {
                        if selectBlocks[idx].value == value.0 {
                            selectBlocks[idx].isAccessible = false
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.bottomView.ttekkkochiCollectionView.reloadData()
                    }
                    self.ttekkkochiCollectionView.reloadData()
                    self.blockIndex += 1
                    
                    switch index {
                    case 4:
                        answerBlocks[index].isShowing = true
                        self.bottomView.isHidden = true
                        self.nextButton.isHidden = false
                        nextButton.setup(model: settingButtonViewModel)
                        self.ttekkkochiCollectionView.reloadData()
                        titleLabel.text = "잘했어! 떡꼬치가 잘 만들어졌는지 한번 잘 들어봐!"
                        ttekkkochiCollectionViewElement.accessibilityLabel = "만약에\n떡 하나 주면\n안 잡아먹는다\n아니면\n잡아먹는다\n잘 만들었는데? 이제 호랑이에게 주자!"
                        UIAccessibility.post(notification: .layoutChanged, argument: titleLabel)
                    default:
                        return
                    }
                } else {
                    self.hapticManager = HapticManager()
                    self.hapticManager?.playNomNom()
                }
            }
            .store(in: &cancellable)
    }
    
    @objc
    func popThisView() {
        (0...4).forEach { answerBlocks[$0].isShowing = false }
        self.navigationController?.pushViewController(CustomAlert(), animated: false)
    }
}

// MARK: - Extension
extension TtekkkochiViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answerBlocks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TtekkkochiCollectionViewCell.identifier, for: indexPath) as? TtekkkochiCollectionViewCell else { fatalError() }
        cell.block = answerBlocks[indexPath.row]
        return cell
    }
}

extension TtekkkochiViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.size.width
        return CGSize(width: cellWidth, height: cellWidth/3.2)
    }
}
