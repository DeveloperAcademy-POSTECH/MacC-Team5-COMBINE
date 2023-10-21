//
//  TtekkkochiViewController.swift
//  Codingdong-iOS
//
//  Created by Joy on 10/20/23.
//

import UIKit

final class TtekkkochiViewController: ViewController, ConfigUI {

    // MARK: - Components
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "조건문이 적힌 떡을 터치해서 꼬치에 순서대로 끼워 주세요."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontManager.p_Regular(.body)
        label.textColor = .gs10
        label.numberOfLines = 0
        return label
    }()
    
    private let stickView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var ttekkochiCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.register(TtekkkochiCollectionViewCell.self, forCellWithReuseIdentifier: TtekkkochiCollectionViewCell.identifier)
        view.backgroundColor = .gs90
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private var bottomView: UIView?
    
    // MARK: - View init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        
        // TODO: NavBar 디자인 component로 나오면 수정하기
        self.navigationController?.navigationBar.topItem?.title = "호랑이를 마주친 엄마"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.gs20, .font: FontManager.p_semiBold(.footnote)] //TODO: 폰트 수정해야 함
        
        addComponents()
        setConstraints()
    }
    
    func addComponents() {
        [titleLabel, ttekkochiCollectionView].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(122)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        ttekkochiCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(76)
            $0.left.equalToSuperview().offset(95)
            $0.right.equalToSuperview().offset(-95)
            $0.bottom.equalToSuperview().offset(-226)
        }
    }
}

extension TtekkkochiViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TtekkkochiCollectionViewCell.identifier, for: indexPath) as? TtekkkochiCollectionViewCell else { fatalError() }
        cell.block = codingBlocks[indexPath.row]
        cell.configUI(.selected) 
        return cell
    }
}

extension TtekkkochiViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.size.width
        return CGSize(width: cellWidth, height: cellWidth/3.2)
    }
}
