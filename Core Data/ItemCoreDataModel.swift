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

extension ItemCoreDataModel {

    var categoryType: Category {
        guard let category = self.category else { return Category.specialOffer }
        return Category(rawValue: category) ?? Category.specialOffer
    }

    var titleUnwrapped: String {
        return self.title ?? ""
    }

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
