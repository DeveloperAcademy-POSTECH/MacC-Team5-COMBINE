import UIKit
import Log
import SwiftData

final class StoryListTableView: UIView {

    var viewModel: MyBookShelfViewModelRepresentable?
    @Published var fableDataList: [FableData]?
    
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
        fableDataList?.forEach {
            Log.n($0.title)
            Log.d($0.isRead)
        }
        
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
        self.storyListTableView.reloadData()
    }
}

// MARK: - Extension
extension StoryListTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fableDataList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryListTableViewCell.identifier , for: indexPath) as? StoryListTableViewCell else { fatalError() }
        cell.model = fableDataList?[indexPath.row] ?? FableData(title: "", isRead: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if fableDataList?[indexPath.row].title == "해님달님" {
            self.viewModel?.moveOn(.sunmoon)
        } else if fableDataList?[indexPath.row].title == "콩쥐팥쥐" {
            self.viewModel?.moveOn(.kongjipatji)
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
