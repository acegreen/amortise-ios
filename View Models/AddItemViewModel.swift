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
    @Published var principleAmount = ""
    @Published var purchaseDate = Date()
    @Published var note = ""
    @Published var showTypeDrop = false
    @Published var showTagDrop = false
    
    @Published var selectedCategory: CategoryType = .entertainment
    @Published var buttonTitle: String = ""
    
    @Published var imageUpdated = false // When item edit, check if attachment is updated?
    @Published var imageAttached: UIImage? = nil
    
    @Published var alertMsg = String()
    @Published var showAlert = false
    @Published var closePresenter = false
    
    init(coreDataObject: ItemCoreDataModel? = nil) {
        
        self.coreDataObject = coreDataObject
        self.title = coreDataObject?.title ?? ""
        if let coreDataObject = coreDataObject {
            self.principleAmount = String(coreDataObject.principleAmount)
        } else {
            self.principleAmount = ""
        }
        self.purchaseDate = coreDataObject?.purchaseDate ?? Date()
        self.note = coreDataObject?.note ?? ""
        if let category = CategoryType(rawValue: coreDataObject?.category ?? CategoryType.allCases[0].rawValue) {
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
    
    func saveItem(managedObjectContext: NSManagedObjectContext) {
        
        let itemCoreDataModel: ItemCoreDataModel
        let titleStr = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let principleAmountString = principleAmount.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if titleStr.isEmpty || titleStr == "" {
            alertMsg = "Enter Title"; showAlert = true
            return
        }
        if principleAmountString.isEmpty || principleAmountString == "" {
            alertMsg = "Enter Amount"; showAlert = true
            return
        }
        guard let principleAmount = Double(principleAmountString) else {
            alertMsg = "Enter valid number"; showAlert = true
            return
        }
        guard principleAmount >= 0 else {
            alertMsg = "Amount can't be negative"; showAlert = true
            return
        }
        guard principleAmount <= 1000000000 else {
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
            itemCoreDataModel.createdDate = Date()
            if let image = imageAttached {
                itemCoreDataModel.imageAttached = image.jpegData(compressionQuality: 1.0)
            }
        }
        itemCoreDataModel.updatedDate = Date()
        itemCoreDataModel.purchaseDate = self.purchaseDate
        itemCoreDataModel.title = titleStr
        itemCoreDataModel.category = selectedCategory.rawValue
        itemCoreDataModel.note = note
        itemCoreDataModel.principleAmount = principleAmount
        do {
            try managedObjectContext.save()
            closePresenter = true
        } catch { alertMsg = "\(error)"; showAlert = true }
    }
    
    func deleteItem(managedObjectContext: NSManagedObjectContext) {
        guard let coreDataObject = coreDataObject else { return }
        managedObjectContext.delete(coreDataObject)
        do {
            try managedObjectContext.save(); closePresenter = true
        } catch { alertMsg = "\(error)"; showAlert = true }
    }
}
