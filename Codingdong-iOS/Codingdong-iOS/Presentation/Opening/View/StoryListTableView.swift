//
//  StoryListTableView.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/11/05.
//

import UIKit
import Log

final class StoryListTableView: UIView {

    var viewModel: MyBookShelfViewModelRepresentable?
    
    // TODO: Separator 오류 해결해야 함
    private lazy var storyListTableView: UITableView = {
        let view = UITableView()
        view.layer.cornerRadius = 10
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .gs80
        view.isScrollEnabled = false
        view.isAccessibilityElement = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(storyListTableView)
        storyListTableView.snp.makeConstraints {
            $0.left.top.right.bottom.equalToSuperview()
        }
        storyListTableView.register(StoryListTableViewCell.self, forCellReuseIdentifier: StoryListTableViewCell.identifier)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Extension
extension StoryListTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fableList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryListTableViewCell.identifier , for: indexPath) as? StoryListTableViewCell else { fatalError() }
        cell.model = fableList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if fableList[indexPath.row].title == "해님달님" {
            self.viewModel?.moveOn(.sunmoon)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension StoryListTableView: MyBookShelfViewRepresentable {
    func setup(with viewModel: MyBookShelfViewModelRepresentable) {
        self.viewModel = viewModel
    }
}
