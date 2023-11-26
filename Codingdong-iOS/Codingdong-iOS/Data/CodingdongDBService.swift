//
//  FableDBService.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/22/23.
//

import Foundation
import SwiftData
import Log

final class CodingdongDBService {
    static var shared = CodingdongDBService()
    var container: ModelContainer?
    var context: ModelContext?
    
    init() {
        do {
            container = try ModelContainer(for: FableData.self, FoodList.self)
            if let container { context = ModelContext(container) }
            self.fetchFable { data, error in
                if let error { Log.e(error) }
                if data?.count == 0 { fables.forEach { self.context?.insert($0) } }
            }
        } catch { Log.e(error.localizedDescription) }
    }
    
    // 전래동화
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
    
    // 개념 간식
    func fetchFoodList(onCompletion: @escaping([FoodList]?, Error?) -> Void) {
        let descriptor = FetchDescriptor<FoodList>()
        
        if let context {
            do {
                let data = try context.fetch(descriptor)
                onCompletion(data,nil)
            } catch { onCompletion(nil,error) }
        }
    }
    
    func saveFoodList(foodList: FoodList) {
        guard let context = context else { return }
        context.insert(foodList)
    }
}
