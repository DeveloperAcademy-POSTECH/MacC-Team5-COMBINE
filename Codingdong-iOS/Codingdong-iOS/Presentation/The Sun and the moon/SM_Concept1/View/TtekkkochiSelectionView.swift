//
//  TtekkkochiSelectionView.swift
//  Codingdong-iOS
//
//  Created by Joy on 10/21/23.
//

import UIKit
import Log

final class TtekkkochiSelectionView: UIView {
    
    var viewModel: TtekkkochiViewModelRepresentable?
    @Published var selectedValue = ""
    @Published var initialValue: Bool = false
    
    let containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .gs60
        view.layer.cornerRadius = 14
        return view
    }()
    
    // TODO: disable 처리나 accessbilityLabel을 안 읽는 방향으로
    lazy var ttekkkochiCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.register(TtekkkochiCollectionViewCell.self, forCellWithReuseIdentifier: TtekkkochiCollectionViewCell.identifier)
        view.dataSource = self
        view.backgroundColor = .clear
        view.delegate = self
        return view
    }()

    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(ttekkkochiCollectionView)
        ttekkkochiCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.left.right.equalToSuperview()
        }
        
        for idx in (0...4) {

            print("================")
            Log.c(selectBlocks[idx].value)
            Log.c(selectBlocks[idx].isAccessible)
            print("================")
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Extension
extension TtekkkochiSelectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TtekkkochiCollectionViewCell.identifier, for: indexPath) as? TtekkkochiCollectionViewCell else { fatalError() }
        cell.block = selectBlocks[indexPath.row]
        return cell
    }
}

extension TtekkkochiSelectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TtekkkochiCollectionViewCell else { return }
        initialValue = true
        selectedValue = cell.block.value
    }
}

extension TtekkkochiSelectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 64)
    }
}

extension TtekkkochiSelectionView: TtekkkochiViewRepresentable {

    func setup(with viewModel: TtekkkochiViewModelRepresentable) {
        self.viewModel = viewModel
    }
}
