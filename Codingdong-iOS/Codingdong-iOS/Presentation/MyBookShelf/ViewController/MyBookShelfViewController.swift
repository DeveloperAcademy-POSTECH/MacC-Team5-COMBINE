//
//  MyBookShelfViewController.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/11/03.
//

import UIKit

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
    
    private lazy var moreStoryButton: UILabel = {
        let label = UILabel()
        label.text = "더보기"
        label.font = FontManager.caption2()
        label.textColor = .secondary1
        label.tag = MoreButtonType.moreStory.rawValue
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
        [storyTitle, badgeTitle, moreStoryButton, moreBadgeButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        storyTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(122)
            $0.left.equalToSuperview().offset(16)
        }
        
        badgeTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(381)
            $0.left.equalToSuperview().offset(16)
        }
        
        moreStoryButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalTo(storyTitle.snp.bottom)
        }
        
        moreBadgeButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalTo(badgeTitle.snp.bottom)
        }
        
    }
    
    func setupAccessibility() {
        navigationItem.accessibilityElements = [navigationTitle]
        view.accessibilityElements = [storyTitle, moreStoryButton, badgeTitle, moreBadgeButton]
    }
    
}

extension MyBookShelfViewController {
    
    enum MoreButtonType: Int {
        case moreStory = 1
        case moreBadge = 2
        case defaultValue = 0
    }
    
    @objc
    func handleButtonTapped(_ sender: UITapGestureRecognizer) {
        if let type = MoreButtonType(rawValue: sender.view?.tag ?? 0) {
            switch type {
            case .moreStory:
                Log().info("moreStory")
            case .moreBadge:
                Log().info("moreBadge")
            case .defaultValue:
                Log().info("Item has no tag")
            }
        }
    }
    
}
