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
        label.text = """
        화면 중앙에 다섯 개의 떡들로 이루어진 떡꼬치가 있어.
        
        핸드폰 화면이 하늘을 바라보도록 해 볼까?
        """
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.textAlignment = .center
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
        //view.backgroundColor = .systemRed
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
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
        [titleLabel, ttekkkochiCollectionView, nextButton, stickView].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(naviLine.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        ttekkkochiCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.left.right.equalToSuperview().inset(95)
            $0.bottom.equalToSuperview().offset(-150)
        }
        
        stickView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.left.right.equalToSuperview().inset(191)
            $0.bottom.equalToSuperview().offset(-130)
        }
        
        self.view.sendSubviewToBack(stickView)
        
        nextButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(Constants.Button.buttonPadding)
            $0.bottom.equalToSuperview().inset(Constants.Button.buttonPadding * 2)
            $0.height.equalTo(72)
        }
    }
    
    func setupAccessibility() {
        let leftBarButtonElement = setupLeftBackButtonItemAccessibility(label: "내 책장")
        ttekkkochiCollectionViewElement.accessibilityFrameInContainerSpace = ttekkkochiCollectionView.frame
        view.accessibilityElements = [titleLabel, ttekkkochiCollectionViewElement, nextButton, leftBarButtonElement]
    }
    
    func binding() {
        initializeView()
        self.viewModel.route
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] nextView in
                self?.navigationController?.pushViewController(nextView, animated: false)
            })
            .store(in: &cancellable)
            
        
//        self.bottomView.$selectedValue
//            .zip(bottomView.$initialValue)
//            .sink { [weak self] value in
//                guard let index = self?.blockIndex else { return }
//                guard value.1 else { return }
//                guard let self = self else { return }
//        
//                // 정답일 때
//                if (index > -1 && index < 5) && (answerBlocks[index].value == value.0) {
//                    answerBlocks[index].isShowing = true
//                    DispatchQueue.global().async {
//                        SoundManager.shared.playSound(sound: .bell)
//                    }
//
//                    for idx in (0...4) where selectBlocks[idx].value == value.0 {
//                        selectBlocks[idx].isAccessible = false
//                        selectBlocks[idx].isShowing = false
//                    }
//                    
//                    self.ttekkkochiCollectionView.reloadData()
//                    self.blockIndex += 1
//                    
//                    switch index {
//                    case 4:
//                        answerBlocks[index].isShowing = true
//                        self.bottomView.isHidden = true
//                        self.nextButton.isHidden = false
//                        nextButton.setup(model: settingButtonViewModel)
//                        self.ttekkkochiCollectionView.reloadData()
//                        titleLabel.text = "잘했어! 떡꼬치가 잘 만들어졌는지 한번 잘 들어봐!"
//                        ttekkkochiCollectionViewElement.accessibilityLabel = "만약에\n떡 하나 주면\n안 잡아먹는다\n아니면\n잡아먹는다\n잘 만들었는데? 이제 호랑이에게 주자!"
//                        UIAccessibility.post(notification: .layoutChanged, argument: titleLabel)
//                    default:
//                        return
//                    }
//                } else {
//                    self.hapticManager = HapticManager()
//                    self.hapticManager?.playNomNom()
//                }
//            }
//            .store(in: &cancellable)
    }
    
    func initializeView() {
        (0...4).forEach {
            answerBlocks[$0].isShowing = false
            selectBlocks[$0].isAccessible = true
            selectBlocks[$0].isShowing = true
            ttekkkochiCollectionView.reloadData()
        }
    }
    
    @objc
    func popThisView() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.ttekkkochiCollectionView.reloadData()
        }
        
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
