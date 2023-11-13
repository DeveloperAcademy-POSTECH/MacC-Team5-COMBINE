//
//  PermissionManager.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 11/13/23.
//

import Foundation
import AVFoundation
import Log
import UIKit

class PermissionManager: ObservableObject {
    @Published var permissionGranted = false
    
    func requestMicPermission() {
        AVCaptureDevice.requestAccess(for: .audio, completionHandler: { (permissionGranted: Bool) in
            if permissionGranted {
                Log.t("Audio: 권한 허용")
            } else {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                Log.t("Audio: 권한 거부")
            }
        })
    }
}
