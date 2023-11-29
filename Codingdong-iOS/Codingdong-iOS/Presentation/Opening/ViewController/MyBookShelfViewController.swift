//
//  MyBookShelfViewController.swift
//  Codingdong-iOS
//

import UIKit
import Combine
import Log

enum NextViewType {
    case sunmoon
    
    fileprivate var viewController: UIViewController {
        switch self {
        case .sunmoon:
            return SunAndMoonIntroViewController()
        }
    }
}

final class MyBookShelfViewController: UIViewController, ConfigUI {
    
    var window: UIWindow?
    var viewModel = MyBookShelfViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let navigationTitle: UILabel = {
        let label = UILabel()
        label.text = "내 책장"
        label.font = FontManager.navigationtitle()
        label.textColor = .gs20
        return label
    }()
    
    private let storyTitle: UILabel = {
        let label = UILabel()
        label.text = "전래동화"
        label.font = FontManager.subhead()
        label.textColor = .gs10
        return label
    }()
    
    private let badgeTitle: UILabel = {
        let label = UILabel()
        label.text = "개념 간식 모음"
        label.font = FontManager.subhead()
        label.textColor = .gs10
        return label
    }()
    
    private lazy var moreTitleButton: UILabel = {
        let label = UILabel()
        label.text = "더보기"
        label.font = FontManager.caption2()
        label.textColor = .secondary1
        label.tag = MoreButtonType.moreTitle.rawValue
        label.isUserInteractionEnabled = true
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(handleButtonTapped))
        label.addGestureRecognizer(labelTap)
        return label
    }()
    
    private lazy var moreBadgeButton: UILabel = {
        let label = UILabel()
        label.text = "더보기"
        label.font = FontManager.caption2()
        label.textColor = .secondary1
        label.tag = MoreButtonType.moreBadge.rawValue
        label.isUserInteractionEnabled = true
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(handleButtonTapped))
        label.addGestureRecognizer(labelTap)
        return label
    }()
    
    // 전래동화
    private let storyList = StoryListTableView()
    
    // 개념 간식 모음
    private let cookieContainer: UIView = {
       let view = UIView()
        view.backgroundColor = .gs80
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let innerLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.text = """
        간식이 없어요.
        동화를 읽으러 가 보아요!
        """
        label.font = FontManager.footnote()
        label.textColor = .gs40
        label.textAlignment = .center
        return label
    }()
    
    private let innerView = YugwaCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupAccessibility()
        setupRootView()
        setupNavigationBar()
        addComponents()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        binding()
    }
    
    func setupRootView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let root = UINavigationController(rootViewController: MyBookShelfViewController())
        window?.makeKeyAndVisible()
        window?.rootViewController = root
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
        navigationController?.navigationBar.accessibilityElementsHidden = true
    }
    
    func addComponents() {
        [storyTitle, badgeTitle, moreTitleButton, moreBadgeButton, storyList, cookieContainer].forEach {
            view.addSubview($0)
        }
        
        // TODO: 더보기 잠시 해제
        [moreTitleButton, moreBadgeButton].forEach { $0.isHidden = true }
        [innerView, innerLabel].forEach { cookieContainer.addSubview($0) }
    }
    
    func setConstraints() {
        storyList.setup(with: viewModel)
        
        storyTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(122)
            $0.left.equalToSuperview().offset(18)
        }
        
        badgeTitle.snp.makeConstraints {
            $0.top.equalTo(naviLine.snp.bottom).offset(280)
            $0.left.equalToSuperview().offset(18)
        }
        
        moreTitleButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-18)
            $0.bottom.equalTo(storyTitle.snp.bottom)
        }
        
        moreBadgeButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-18)
            $0.bottom.equalTo(badgeTitle.snp.bottom)
        }
        
        storyList.snp.makeConstraints {
            $0.top.equalTo(storyTitle.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(180)
        }
        
        cookieContainer.snp.makeConstraints {
            $0.top.equalTo(badgeTitle.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-32)
        }
        
        innerLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        innerView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
    }
    
    func setupAccessibility() {
        let naviTitleElement = setupNavigationTitleAccessibility(label: navigationTitle.text ?? "타이틀 없음")
        view.accessibilityElements = [naviTitleElement, storyTitle, storyList, badgeTitle, innerLabel, innerView.badgeCollectionView]
        [storyTitle, badgeTitle].forEach { $0.accessibilityTraits = .header }
    }
    
    func fetchData() {
        if (CddDBService().readFoodListData().haveFood == false) {
            self.innerLabel.isHidden = false
            self.innerView.isHidden = true
        } else {
            self.innerView.food = CddDBService().readFoodListData().food?.sorted(by: {$0.image < $1.image})
            self.innerView.badgeCollectionView.reloadData()
            self.innerLabel.isHidden = true
            self.innerView.isHidden = false
        }
    }
    
    func binding() {
//        storyList.setup(with: viewModel)
        
        viewModel.route
            .receive(on: DispatchQueue.main)
            .sink { [weak self] route in
                self?.navigationController?.pushViewController(route.viewController, animated: false)
            }
            .store(in: &cancellable)
    }
}

extension MyBookShelfViewController {
    enum MoreButtonType: Int {
        case moreTitle = 1
        case moreBadge = 2
        case defaultValue = 0
    }
    
    @objc
    func handleButtonTapped(_ sender: UITapGestureRecognizer) {
        if let type = MoreButtonType(rawValue: sender.view?.tag ?? 0) {
            switch type {
            case .moreTitle:
                Log.i("스토리 더보기로 이동")
            case .moreBadge:
                Log.i("개념 간식 모음 더보기로 이동")
            case .defaultValue:
                Log.c("디폴트")
            }
        }
    }
}
