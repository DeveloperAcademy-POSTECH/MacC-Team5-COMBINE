//
//  FableDBService.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/22/23.
//

import Foundation
import SwiftData
import Log

final class FableDBService {
    static var shared = FableDBService()
    var container: ModelContainer?
    var context: ModelContext?
    
    init() {
        do {
            container = try ModelContainer(for: FableData.self)
            if let container { context = ModelContext(container) }
            self.fetchFable { data, error in
                if let error { Log.e(error) }
                if data?.count == 0 { fables.forEach { self.context?.insert($0) } }
            }
        } catch { Log.e(error.localizedDescription) }
    }
    
    func fetchFable(onCompletion: @escaping([FableData]?, Error?) -> Void) {
        let descriptor = FetchDescriptor<FableData>(sortBy: [SortDescriptor<FableData>(\.title, order: .reverse)])
        
        if let context {
            do {
                let data = try context.fetch(descriptor)
                onCompletion(data,nil)
            } catch { onCompletion(nil,error) }
        }
    }
    
    func updateFable(fable: FableData, checkRead: Bool) {
        let readFable = fable
        readFable.isRead = checkRead
    }
}
