//
//  WindowHoleViewController.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 11/6/23.
//

import UIKit
import SnapKit

final class WindowHoleViewController: UIViewController {
    // MARK: - Components
    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "구멍을 탭해서 문 밖에 누가 있는지 확인해주세요."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let windowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "initialDoor")
        return imageView
    }()
    
    private let tigerHandHoleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tigerHandHoleBefore")
        return imageView
    }()
    
    private let tigerNoseHoleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tigerNoseHoleBefore")
        return imageView
    }()
    
    private let tigerTailHoleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tigerTailHoleBefore")
        return imageView
    }()
    
    private let nextButton = CommonButton()
    private lazy var nextButtonViewModel = CommonbuttonModel(title: "다음",font: FontManager.textbutton(), titleColor: .primary1, backgroundColor: .primary2) { [weak self] in
        self?.navigationController?.pushViewController(GiveTtekkViewController(), animated: false)
    }
    
    // MARK: - View init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        setupNavigationBar()
        addComponents()
        setConstraints()
        nextButton.setup(model: nextButtonViewModel)
    }
    
    func setupNavigationBar() {
        view.addSubview(naviLine)
        self.title = "남매의 집에 도착한 호랑이"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.gs20, .font: FontManager.navigationtitle()]
        self.navigationController?.navigationBar.tintColor = .gs20
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "books.vertical"),
            style: .plain,
            target: self,
            action: .none
        )
    }
    
    func addComponents() {
        [titleLabel, windowImageView, tigerHandHoleImageView, tigerNoseHoleImageView, tigerTailHoleImageView, nextButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        naviLine.snp.makeConstraints {
            $0.top.equalToSuperview().offset(106)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.33)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(122)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        windowImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(51)
            $0.right.equalToSuperview().offset(-51)
            $0.top.equalToSuperview().offset(214)
            $0.bottom.equalToSuperview().offset(-160)
        }
        
        tigerHandHoleImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(102)
            $0.top.equalToSuperview().offset(401)
        }
        
        tigerNoseHoleImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(226)
            $0.top.equalToSuperview().offset(305)
        }
        
        tigerTailHoleImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(204)
            $0.top.equalToSuperview().offset(537)
        }
        
        nextButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Constants.Button.buttonPadding)
            $0.right.equalToSuperview().offset(-Constants.Button.buttonPadding)
            $0.bottom.equalToSuperview().offset(-Constants.Button.buttonPadding * 2)
            $0.height.equalTo(72)
        }
    }
    
    func animatedImages(for name: String) -> [UIImage] {
        var images = [UIImage]()
        let image1 = UIImage(named: "tigerHandHoleBefore.png")!
        let image2 = UIImage(named: "tigerHandHoleAfter.png")!
        images.append(image1)
        images.append(image2)
        return images
    }
}
