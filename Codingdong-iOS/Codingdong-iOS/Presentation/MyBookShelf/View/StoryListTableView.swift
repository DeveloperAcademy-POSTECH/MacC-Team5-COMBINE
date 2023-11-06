//
//  StoryListTableView.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/11/05.
//

import UIKit
import SnapKit

final class StoryListTableView: UIView {
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var storyListTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(StoryListTableViewCell.self, forCellReuseIdentifier: StoryListTableViewCell.identifier)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .gs80
        
        view.separatorStyle = .singleLine
        view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.separatorInsetReference = .fromAutomaticInsets
        view.separatorColor = .white
        
        return view
    }()
    
    let data = ["해님달님", "콩쥐팥쥐", "별주부전"]
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(storyListTableView)
        storyListTableView.snp.makeConstraints {
            $0.left.top.equalToSuperview()
            $0.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension StoryListTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryListTableViewCell.identifier , for: indexPath) as? StoryListTableViewCell else { fatalError() }
        cell.storyTitle = storyList[indexPath.row]
//        cell.configure(with: storyList[indexPath.row])

        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cell.bounds.size.width - 20)
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        return cell
    }
}

extension StoryListTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: 전래동화 선택시 해당 뷰로 내비게이션 연결해야함
//        tableView.cellForRow(at: indexPath)?.backgroundColor = .red
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
