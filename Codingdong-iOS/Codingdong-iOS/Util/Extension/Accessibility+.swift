//
//  UIView+.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/11/21.
//

import UIKit

extension UIViewController {
    
    func sendFocusTo(view: UIView) {
        Task {
            // Delay the task by 500 milliseconds
            try await Task.sleep(nanoseconds: UInt64(0.01 * Double(NSEC_PER_SEC)))
            
            // Send the VoiceOver focus to the specific view
            UIAccessibility.post(notification: .layoutChanged, argument: view)
        }
    }
    
    func announceForAccessibility(_ string: String) {
        Task {
            // Delay the task by 100 milliseconds
            try await Task.sleep(nanoseconds: UInt64(0.1 * Double(NSEC_PER_SEC)))
            
            // Announce the string using VoiceOver
            let announcementString = NSAttributedString(string: string, attributes: [.accessibilitySpeechQueueAnnouncement : true])
            UIAccessibility.post(notification: .announcement, argument: announcementString)
        }
    }
    
    func setupLeftBackButtonItemAccessibility(label: String) -> UIAccessibilityElement {
        let navigationBarFrame = navigationController?.navigationBar.frame ?? CGRect.zero
        
        let leftBarButtonElement = UIAccessibilityElement(accessibilityContainer: view!)
        let leftBarButtonElementFrame = CGRect(x: navigationBarFrame.minX + 8, y: navigationBarFrame.minY, width: 50, height: navigationBarFrame.height)
        
        leftBarButtonElement.accessibilityFrameInContainerSpace = leftBarButtonElementFrame
        leftBarButtonElement.accessibilityLabel = label
        leftBarButtonElement.accessibilityTraits = .button
        
        return leftBarButtonElement
    }
    
    func setupNavigationTitleAccessibility(label: String) -> UIAccessibilityElement {
        let navigationBarFrame = navigationController?.navigationBar.frame ?? CGRect.zero
        
        let naviTitleElement = UIAccessibilityElement(accessibilityContainer: view!)
        let naviTitleElementFrame = CGRect(x: navigationBarFrame.minX + 60, y: navigationBarFrame.minY, width: 280, height: navigationBarFrame.height)
        
        naviTitleElement.accessibilityFrameInContainerSpace = naviTitleElementFrame
        naviTitleElement.accessibilityLabel = label
        naviTitleElement.accessibilityTraits = .header
        
        return naviTitleElement
    }
    
}
