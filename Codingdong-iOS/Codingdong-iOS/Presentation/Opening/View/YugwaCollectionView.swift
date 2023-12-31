import UIKit
import Log

final class YugwaCollectionView: UIView {
    
    @Published var food: [Food]?
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gs80
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var badgeCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.register(YugwaCell.self, forCellWithReuseIdentifier: YugwaCell.identifier)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        return view
    }()
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.addSubview(badgeCollectionView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        badgeCollectionView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        badgeCollectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension YugwaCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return food?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YugwaCell.identifier, for: indexPath) as? YugwaCell else { fatalError() }
        cell.model = food?[indexPath.row] ?? Food(image: "", concept: "")
        return cell
    }
}

extension YugwaCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 157)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 36, bottom: 25, right: 36)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}
