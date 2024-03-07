//
//  FableDBService.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/22/23.
//

import Foundation
import SwiftData

final class CddDBService {
    var context: ModelContext
    var container: ModelContainer = {
        let schema = Schema([FableData.self, FoodList.self, Food.self])
        let modelConfiguration = ModelConfiguration(schema: schema)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    static let shared = CddDBService()
    
    init() { context = ModelContext(container) }
    
    /// CREATE
    func createItem<T: PersistentModel> (_ item: T) { context.insert(item) }
    
    /// READ
    func readItems<T: PersistentModel>(key: [SortDescriptor<T>]?) throws -> [T]? {
        guard let key = key else { fatalError() }
        do {
            return try context.fetch(FetchDescriptor<T>(sortBy: key))
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    /// DELETE
    func deleteItems<T:PersistentModel>(_ item: T) { context.delete(item) }
}

extension CddDBService {
    
    func initializeData() {
        do {
            let fableData = try self.readItems(key: [SortDescriptor<FableData>(\.title)]) ?? [FableData(title: "", isRead: true)]
            if fableData.count == 0 { fables.forEach { self.context.insert($0) } }
            
            let foodList = try self.readItems(key: [SortDescriptor<FoodList>(\.id)]) ?? [FoodList(id: "", haveFood: true)]
            if foodList.count == 0 { self.context.insert(FoodList(id: UUID().uuidString, haveFood: false)) }
        } catch { fatalError(error.localizedDescription) }
    }
    
    func readFableData() -> [FableData] {
        do {
            return try self.readItems(key: [SortDescriptor<FableData>(\.title, order: .reverse)]) ?? [FableData(title: "", isRead: true)]
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func readFoodListData() -> FoodList {
        do {
            return try self.readItems(key: [SortDescriptor<FoodList>(\.id)])?[0] ?? FoodList(id: UUID().uuidString, haveFood: true)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
        
    func updateFood(_ item: Food) {
        let foodList = self.readFoodListData()
        foodList.haveFood = true
        foodList.food?.append(item)
        item.foodList = foodList
        context.insert(foodList)
        do { 
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func updateFable(_ item: FableData) {
        item.isRead = true
        context.insert(item)
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
