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
    var fableDataList = [FableData]()
    
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
        configUI()
        fetchData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configUI() {
        addSubview(storyListTableView)
        storyListTableView.snp.makeConstraints {
            $0.left.top.right.bottom.equalToSuperview()
        }
        storyListTableView.register(StoryListTableViewCell.self, forCellReuseIdentifier: StoryListTableViewCell.identifier)
    }
    
    func fetchData() {
        FableDBService.shared.fetchFable { data, error in
            if let error { Log.e(error) }
            if let data {
                self.fableDataList = data
                self.storyListTableView.reloadData()
            }
        }
    }
}

// MARK: - Extension
extension StoryListTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fableDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryListTableViewCell.identifier , for: indexPath) as? StoryListTableViewCell else { fatalError() }
        cell.model = fableDataList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if fableDataList[indexPath.row].title == "해님달님" {
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
