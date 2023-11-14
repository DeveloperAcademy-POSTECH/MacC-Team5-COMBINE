//
//  TtekkkochiViewController.swift
//  Codingdong-iOS
//
//  Created by Joy on 10/20/23.
//

import UIKit
import Combine

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
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "하단의 떡 블록을 탭 해서 꼬치에 순서대로 끼워 주세요."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
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
        view.backgroundColor = .clear
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private let bottomView = TtekkkochiSelectionView()
    
    private let nextButton = CommonButton()
    private lazy var settingButtonViewModel = CommonbuttonModel(title: "떡을 준다", font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .primary2) {[weak self] in
       self?.viewModel.selectItem()
    }

    // MARK: - View init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupNavigationBar()
        setupAccessibility()
        addComponents()
        setConstraints()
        nextButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        binding()
    }
    
    func setupNavigationBar() {
        view.addSubview(naviLine)
        naviLine.snp.makeConstraints {
            $0.top.equalToSuperview().offset(106)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.33)
        }
        self.title = "호랑이를 마주친 엄마"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.gs20, .font: FontManager.navigationtitle()]
        self.navigationController?.navigationBar.tintColor = .gs20
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "books.vertical"),
            style: .plain,
            target: self,
            action: #selector(popThisView)
        )
    }
    
    func addComponents() {
        [titleLabel, ttekkkochiCollectionView, bottomView, nextButton, stickView].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(122)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        ttekkkochiCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(76)
            $0.left.equalToSuperview().offset(95)
            $0.right.equalToSuperview().offset(-95)
            $0.bottom.equalToSuperview().offset(-226)
        }
        
        stickView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(70)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(8)
            $0.bottom.equalTo(bottomView.snp.top).offset(-50)
        }
        
        self.view.sendSubviewToBack(stickView)
        
        bottomView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Constants.Button.buttonPadding)
            $0.right.equalToSuperview().offset(-Constants.Button.buttonPadding)
            $0.bottom.equalToSuperview().offset(-Constants.Button.buttonPadding * 2)
            $0.height.equalTo(112)
        }
        
        nextButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Constants.Button.buttonPadding)
            $0.right.equalToSuperview().offset(-Constants.Button.buttonPadding)
            $0.bottom.equalToSuperview().offset(-Constants.Button.buttonPadding * 2)
            $0.height.equalTo(72)
        }
    }
    
    func setupAccessibility() {
        view.accessibilityElements = [titleLabel, ttekkkochiCollectionView, bottomView, nextButton]
        self.navigationItem.leftBarButtonItem?.accessibilityLabel = "내 책장"
        ttekkkochiCollectionView.isAccessibilityElement = true
        ttekkkochiCollectionView.accessibilityLabel = "하단의 떡 블록들을 만약, 아니면을 활용해 순서에 맞게 끼워보렴"
        titleLabel.accessibilityTraits = .none
        nextButton.accessibilityLabel = "떡을 준다"
        //TODO: 하단으로 이동시 상단의 떡블록에 대한 라벨 사라져야 함
        nextButton.accessibilityTraits = .button
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
                   
                    self.ttekkkochiCollectionView.reloadData()
                    self.blockIndex += 1
                    
                    switch index {
                    case 4:
                        self.bottomView.isHidden = true
                        self.nextButton.isHidden = false
                        nextButton.setup(model: settingButtonViewModel)
                        // TODO: 떡 크기 확대, tts
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
        self.navigationController?.popToRootViewController(animated: false)
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
