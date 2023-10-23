//
//  Quiz1ViewController.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 10/20/23.
//

import UIKit
import SnapKit

class GiveTtekkViewController: UIViewController {
    
    private var hapticManager: HapticManager?
    
    private var maxShakeCount = 5
    
    private let rectanglesContainerView = UIView()
    private var ttekkRectangleArray: [UIView] = []
    
    lazy var rectangleTtekkView = UIView(frame: .zero)
    let ttekkWidth: CGFloat = 382
    let ttekkheight: CGFloat = 112
    
    private let naviLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()
    
    private let storyLabel : UILabel = {
        let label = UILabel()
        label.text = "앗! 호랑이가 또 떡을 요구해요! 기기를 흔들어서 떡을 주세요!"
        label.font = FontManager.body()
        label.textColor = .gs10
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gs90
        
        setupNavigationBar()
        view.addSubview(storyLabel)
        storyLabel.snp.makeConstraints {
            $0.height.equalTo(68)
            $0.width.equalTo(358)
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(122)
        }
        
        view.addSubview(rectanglesContainerView)
        rectanglesContainerView.backgroundColor = UIColor.clear
        
        rectanglesContainerView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        for i in 0..<maxShakeCount {
            let rect = UIView()
            rect.backgroundColor = UIColor.white
            rect.layer.cornerRadius = 60
            rectanglesContainerView.addSubview(rect)
            ttekkRectangleArray.append(rect)
            
            rect.snp.makeConstraints {
                $0.width.equalTo(ttekkWidth)
                $0.height.equalTo(ttekkheight)
                $0.leading.equalToSuperview().offset(4)
                $0.bottom.equalToSuperview().offset(-4 - i*118)
            }
        }
    }
    
    func setupNavigationBar() {
        view.addSubview(naviLine)
        naviLine.snp.makeConstraints {
            $0.top.equalToSuperview().offset(106)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.33)
        }
        self.navigationController?.navigationBar.topItem?.title = "호랑이를 마주친 엄마"
        self.navigationController?.navigationBar.topItem?.titleView?.tintColor = .yellow
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.gs20, .font: FontManager.navigationtitle()]
        self.navigationController?.navigationBar.tintColor = .gs20
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "books.vertical"),
            style: .plain,
            target: self,
            action: .none
        )
    }
    
    private func handleShake() {
        maxShakeCount -= 1
        
        if !ttekkRectangleArray.isEmpty {
            let removeTukk = ttekkRectangleArray.removeLast()
            removeTukk.removeFromSuperview()
            self.hapticManager = HapticManager()
            self.hapticManager?.playNomNom()
            SoundManager.shared.playTTS("\(maxShakeCount)개")
        } else {
            self.navigationController?.pushViewController(NoTtekkViewController(), animated: true)
        }
    }
    
    // 한번씩 끊어서 흔들기 인식
    // 연속해서 흔드는 것은 멈출때까지 1번이라고 인식
    public override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            handleShake()
        }
    }
    
}
