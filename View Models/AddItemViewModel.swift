//
//  AddItemViewModel.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import UIKit
import CoreData

class AddItemViewModel: ObservableObject {
    
    var coreDataObject: ItemCoreDataModel?
    
    @Published var title = ""
    @Published var amount = ""
    @Published var occuredOn = Date()
    @Published var note = ""
    @Published var showTypeDrop = false
    @Published var showTagDrop = false
    
    @Published var selectedCategory: Category = .specialOffer
    @Published var buttonTitle: String = ""
    
    @Published var imageUpdated = false // When transaction edit, check if attachment is updated?
    @Published var imageAttached: UIImage? = nil
    
    @Published var alertMsg = String()
    @Published var showAlert = false
    @Published var closePresenter = false
    
    init(coreDataObject: ItemCoreDataModel? = nil) {
        
        self.coreDataObject = coreDataObject
        self.title = coreDataObject?.title ?? ""
        if let coreDataObject = coreDataObject {
            self.amount = String(coreDataObject.amount)
        } else {
            self.amount = ""
        }
        self.occuredOn = coreDataObject?.occuredOn ?? Date()
        self.note = coreDataObject?.note ?? ""
        if let category = Category(rawValue: coreDataObject?.category ?? Category.allCases[0].rawValue) {
            self.selectedCategory = category
            self.buttonTitle = category.description
        }
        if let data = coreDataObject?.imageAttached {
            self.imageAttached = UIImage(data: data)
        }
        
        AttachmentHandler.shared.imagePickedBlock = { [weak self] image in
            self?.imageUpdated = true
            self?.imageAttached = image
        }
    }
    
    var actionButtonText: String {
        return "\(coreDataObject == nil ? "ADD" : "EDIT") ITEM"
    }
    
    func attachImage() { AttachmentHandler.shared.showAttachmentActionSheet() }
    
    func removeImage() { imageAttached = nil }
    
    func saveTransaction(managedObjectContext: NSManagedObjectContext) {
        
        let itemCoreDataModel: ItemCoreDataModel
        let titleStr = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let amountStr = amount.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if titleStr.isEmpty || titleStr == "" {
            alertMsg = "Enter Title"; showAlert = true
            return
        }
        if amountStr.isEmpty || amountStr == "" {
            alertMsg = "Enter Amount"; showAlert = true
            return
        }
        guard let amount = Double(amountStr) else {
            alertMsg = "Enter valid number"; showAlert = true
            return
        }
        guard amount >= 0 else {
            alertMsg = "Amount can't be negative"; showAlert = true
            return
        }
        guard amount <= 1000000000 else {
            alertMsg = "Enter a smaller amount"; showAlert = true
            return
        }
        
        if coreDataObject != nil {
            
            itemCoreDataModel = coreDataObject!
            
            if let image = imageAttached {
                if imageUpdated {
                    if let _ = itemCoreDataModel.imageAttached {
                        // Delete Previous Image from CoreData
                    }
                    itemCoreDataModel.imageAttached = image.jpegData(compressionQuality: 1.0)
                }
            } else {
                if let _ = itemCoreDataModel.imageAttached {
                    // Delete Previous Image from CoreData
                }
                itemCoreDataModel.imageAttached = nil
            }
            
        } else {
            itemCoreDataModel = ItemCoreDataModel(context: managedObjectContext)
            itemCoreDataModel.createdAt = Date()
            if let image = imageAttached {
                itemCoreDataModel.imageAttached = image.jpegData(compressionQuality: 1.0)
            }
        }
        itemCoreDataModel.updatedAt = Date()
        itemCoreDataModel.title = titleStr
        itemCoreDataModel.category = selectedCategory.rawValue
        itemCoreDataModel.occuredOn = occuredOn
        itemCoreDataModel.note = note
        itemCoreDataModel.amount = amount
        do {
            try managedObjectContext.save()
            closePresenter = true
        } catch { alertMsg = "\(error)"; showAlert = true }
    }
    
    func deleteTransaction(managedObjectContext: NSManagedObjectContext) {
        guard let coreDataObject = coreDataObject else { return }
        managedObjectContext.delete(coreDataObject)
        do {
            try managedObjectContext.save(); closePresenter = true
        } catch { alertMsg = "\(error)"; showAlert = true }
    }
}
