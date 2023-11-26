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

    var context: ModelContext
    var container: ModelContainer = {
        let schema = Schema([FableData.self, FoodList.self, Food.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() { context = ModelContext(container) }
    
    /// CREATE
    func createItem<T: PersistentModel> (_ item: T) {
        context.insert(item)
    }
    
    /// READ
    func readItems<T: PersistentModel>(key: [SortDescriptor<T>]?, onCompletion: @escaping([T]?, Error?) -> ()) {
        guard let key = key else { return }
        let descriptor = FetchDescriptor<T>(sortBy: key)
        do {
            let data = try context.fetch(descriptor)
            onCompletion(data,nil)
        } catch {
            onCompletion(nil,error)
        }
    }
    /// DELETE
    func deleteItems<T:PersistentModel>(_ item: T) { context.delete(item) }
}
