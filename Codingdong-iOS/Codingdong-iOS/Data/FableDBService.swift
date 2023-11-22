//
//  FableDBService.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/22/23.
//

import Foundation
import SwiftData
import Log

class FableDBService {
    static var shared = FableDBService()
    var container: ModelContainer?
    var context: ModelContext?
    
    init() {
        do {
            container = try ModelContainer(for: FableData.self)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            Log.e(error.localizedDescription)
        }
    }
    
    func fetchFable(onCompletion:@escaping([FableData]?, Error?) -> Void) {
        let descriptor = FetchDescriptor<FableData>()
        
        if let context {
            do {
                let data = try context.fetch(descriptor)
                onCompletion(data,nil)
            } catch {
                onCompletion(nil,error)
            }
        }
    }
    
    func updateFable(fable: FableData, checkRead: Bool) {
        let readFable = fable
        readFable.isRead = checkRead
    }
}
