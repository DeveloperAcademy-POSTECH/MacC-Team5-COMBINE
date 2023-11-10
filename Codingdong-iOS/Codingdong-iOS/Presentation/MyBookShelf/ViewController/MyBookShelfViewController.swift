//
//  MyBookShelfViewController.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/11/03.
//

import UIKit
import Log

final class MyBookShelfViewController: UIViewController, ConfigUI {
    
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
    
    private let storyList = StoryListTableView()
    
    private let badgeCollection = BadgeCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        
        setupAccessibility()
        setupNavigationBar()
        addComponents()
        setConstraints()
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
    }
    
    func addComponents() {
        [storyTitle, badgeTitle, moreTitleButton, moreBadgeButton, storyList, badgeCollection].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        storyTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(122)
            $0.left.equalToSuperview().offset(18)
        }
        
        badgeTitle.snp.makeConstraints {
            $0.top.equalTo(storyList.snp.bottom).offset(32)
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
        
        badgeCollection.snp.makeConstraints {
            $0.top.equalTo(badgeTitle.snp.bottom).offset(16)
            $0.left.equalTo(16)
            $0.right.equalTo(-16)
            $0.bottom.equalToSuperview().offset(-32)
        }
    }
    
    func setupAccessibility() {
        navigationItem.accessibilityElements = [navigationTitle]
        view.accessibilityElements = [storyTitle, moreTitleButton, badgeTitle, moreBadgeButton]
        // TODO: 각 요소에 Accessibility 적용
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
        // TODO: 각 버튼 별 더보기 뷰로 내비게이션 구현해야함.
        if let type = MoreButtonType(rawValue: sender.view?.tag ?? 0) {
            switch type {
            case .moreTitle:
                Log.i("더보기:스토리")
                self.navigationController?.pushViewController(MoreTItleViewController(), animated: false)
            case .moreBadge:
                Log.i("더보기:뱃지")
                self.navigationController?.pushViewController(MoreBadgeViewController(), animated: false)
            case .defaultValue:
                Log.c("디폴트")
            }
        }
    }
    
}
