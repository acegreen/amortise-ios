//
//  ItemData.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import Foundation
import CoreData

enum ItemCoreDataModelSort: String {
    case createdAt
    case updatedAt
    case occuredOn
}

enum ItemCoreDataModelFilterTime: String {
    case all
    case week
    case month
}

public class ItemCoreDataModel: NSManagedObject, Identifiable {
    @NSManaged public var createdAt: Date?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var type: String?
    @NSManaged public var title: String?
    @NSManaged public var tag: String?
    @NSManaged public var occuredOn: Date?
    @NSManaged public var note: String?
    @NSManaged public var amount: Double
    @NSManaged public var imageAttached: Data?
}

extension ItemCoreDataModel {
    static func getAllExpenseData(sortBy: ItemCoreDataModelSort = .occuredOn, ascending: Bool = true, filterTime: ItemCoreDataModelFilterTime = .all) -> NSFetchRequest<ItemCoreDataModel> {
        let request: NSFetchRequest<ItemCoreDataModel> = ItemCoreDataModel.fetchRequest() as! NSFetchRequest<ItemCoreDataModel>
        let sortDescriptor = NSSortDescriptor(key: sortBy.rawValue, ascending: ascending)
        if filterTime == .week {
            let startDate: NSDate = Date().getLast7Day()! as NSDate
            let endDate: NSDate = NSDate()
            let predicate = NSPredicate(format: "occuredOn >= %@ AND occuredOn <= %@", startDate, endDate)
            request.predicate = predicate
        } else if filterTime == .month {
            let startDate: NSDate = Date().getLast30Day()! as NSDate
            let endDate: NSDate = NSDate()
            let predicate = NSPredicate(format: "occuredOn >= %@ AND occuredOn <= %@", startDate, endDate)
            request.predicate = predicate
        }
        request.sortDescriptors = [sortDescriptor]
        return request
    }
}

struct ItemData {
    static let manufacturer = ManufacturerModel(name: "David Berlin", bio: "Socialist & Developer", image: MANUFACTURER_IMAGE)
    static let items = [
        ItemModel(id: 124, name: "Parkinson", age: 2, gender: "male", color: "Brown", weight: 14, location: "341m", image: ITEM_IMAGE_BLUE, about: "Playful", manufacturer: manufacturer),
        ItemModel(id: 785, name: "Daisy", age: 3, gender: "female", color: "Brown", weight: 14, location: "541m", image: ITEM_IMAGE_ORANGE, about: "Playful", manufacturer: manufacturer),
        ItemModel(id: 485, name: "Oscar", age: 4, gender: "male", color: "Brown", weight: 14, location: "410m", image: ITEM_IMAGE_WHITE, about: "Playful", manufacturer: manufacturer),
        ItemModel(id: 452, name: "Milo", age: 4, gender: "male", color: "Brown", weight: 14, location: "243m", image: ITEM_IMAGE_RED, about: "Playful", manufacturer: manufacturer),
        ItemModel(id: 369, name: "Ruby", age: 5, gender: "female", color: "Brown", weight: 14, location: "114m", image: ITEM_IMAGE_YELLOW, about: "Playful", manufacturer: manufacturer)
    ]
}
