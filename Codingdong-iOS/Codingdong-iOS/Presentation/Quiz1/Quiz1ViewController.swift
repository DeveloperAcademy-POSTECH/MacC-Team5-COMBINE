//
//  Quiz1ViewController.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 10/20/23.
//

import UIKit
import SnapKit
import CoreMotion

class Quiz1ViewController: UIViewController {
    
    private var maxShakeCount = 5
    
    private let rectanglesContainerView = UIView()
    private var ttekkRectangleArray: [UIView] = []
    
    lazy var rectangleTtekkView = UIView(frame: .zero)
    let ttekkWidth: CGFloat = 382
    let ttekkheight: CGFloat = 112
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
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
        
        // CoreMotion을 사용한 방법
        // Threshold를 조절해서 인식 강도 조절 가능
//        if motionManager.isAccelerometerAvailable {
//            motionManager.accelerometerUpdateInterval = 0.2  // Adjust the interval as needed
//            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
//                if let acceleration = data?.acceleration {
//                    let shakeThreshold = 2.0  // 흔들기 인식 강도
//                    if acceleration.x >= shakeThreshold || acceleration.y >= shakeThreshold || acceleration.z >= shakeThreshold {
//                        // A shake motion is detected
//                        self.handleShake()
//                    }
//                }
//            }
//        }
    }
    
    private func handleShake() {
        maxShakeCount -= 1
        print("Shaked! Count: \(maxShakeCount)")
        
        if !ttekkRectangleArray.isEmpty {
            let removeTukk = ttekkRectangleArray.removeLast()
            removeTukk.removeFromSuperview()
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

import SwiftUI

struct Quiz1ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = Quiz1ViewController
    
    func makeUIViewController(context: Context) -> Quiz1ViewController {
        return Quiz1ViewController()
    }
    
    func updateUIViewController(_ uiViewController: Quiz1ViewController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View{
        Quiz1ViewControllerRepresentable()
    }
}
