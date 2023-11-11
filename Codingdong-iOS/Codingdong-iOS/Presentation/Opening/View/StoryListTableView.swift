//
//  StoryListTableView.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/11/05.
//

import UIKit
import Log

final class StoryListTableView: UIView {

    // TODO: Separator 오류 해결해야 함 
    private lazy var storyListTableView: UITableView = {
        let view = UITableView()
        view.layer.cornerRadius = 10
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .gs80
        view.isScrollEnabled = false
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
extension StoryListTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryListTableViewCell.identifier , for: indexPath) as? StoryListTableViewCell else { fatalError() }
        cell.model = fableList[indexPath.row]
        return cell
    }
}

extension StoryListTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: 전래동화 선택시 해당 뷰로 내비게이션 연결해야함
        Log.i("didSelect")

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
