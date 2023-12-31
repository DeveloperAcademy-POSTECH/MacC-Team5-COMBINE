//
//  FableDBService.swift
//  Codingdong-iOS
//
//  Created by Joy on 11/22/23.
//

import Foundation
import SwiftData
import Log

struct CddDBService {
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
    
    init() { context = ModelContext(container) }
    
    /// CREATE
    func createItem<T: PersistentModel> (_ item: T) { context.insert(item) }
    
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

extension CddDBService {
    func initializeData() {
        self.readItems(key: [SortDescriptor<FableData>(\.title)]) { data, error in
            if let error { Log.e(error) }
            if data?.count == 0 { fables.forEach { self.context.insert($0) } }
        }
        self.readItems(key: [SortDescriptor<FoodList>(\.id)]) { data, error in
            if let error { Log.e(error) }
            if data?.count == 0 {
                self.context.insert(FoodList(id: UUID().uuidString, haveFood: false))
            }
        }
    }
    
    func readFableData() -> [FableData] {
        var fableData: [FableData] = []
        self.readItems(key: [SortDescriptor<FableData>(\.title, order: .reverse)]) { data, error in
            if let error { Log.e(error) }
            guard let data = data else { return }
            fableData = data
        }
        return fableData
    }
    
    func readFoodListData() -> FoodList {
        var foodListData: FoodList?	
        self.readItems(key: [SortDescriptor<FoodList>(\.id)]) { data, error in
            if let error { Log.e(error) }
            guard let data = data else { return }
            foodListData = data[0]
        }
        return foodListData ?? FoodList(id: UUID().uuidString, haveFood: false)
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
        let fableData = self.readFableData()
        item.isRead = true
        context.insert(item)
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
