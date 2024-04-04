//
//  Inventory.swift
//  Emerlad Helper
//
//  Created by Natividad Michael Salinas II on 3/7/24.
//

import Foundation
import FirebaseFirestore


class Inventory {
    
    let db = Firestore.firestore()
    
    private var warehouseInventory: [Item] = []
    private var truckInventory: [Item] = []
    private var catalogInventory: [Item] = []
    
    // Initialize
    init(warehouseInventory: [Item] = [], truckInventory: [Item] = [], catalogInventory: [Item] = []) {
        self.warehouseInventory = warehouseInventory
        self.truckInventory = truckInventory
    }
    
   
    var warehouseInventoryPublic: [Item] {
        get { return warehouseInventory }
        set { warehouseInventory = newValue }
    }
    
    var truckInventoryPublic: [Item] {
        get { return truckInventory }
        set { truckInventory = newValue }
    }
    var catalogInventoryPublic: [Item] {
        get { return catalogInventory}
        set { catalogInventory = newValue }
    }
    
    // Method to add an item to the warehouse inventory
    func addItemToWarehouse(item: Item) {
            warehouseInventory.append(item) // Add to local array
            // Convert Item to dictionary for Firestore
            let itemDict = [
                "name": item.namePublic,
                "manufacturer": item.manufacturerPublic,
                "cost": item.costPublic ?? nil,
                "weight": item.weightPublic ?? 0,
                "receiveDate": item.receiveDatePublic ?? Date(),
                "supplier": item.supplierPublic ?? "",
                "itemPictureURL": item.itemPictureURLPublic ?? ""
            ] as [String : Any]
            // Add item to Firestore
            db.collection("Warehouse Inventory").addDocument(data: itemDict) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added with ID:")
                }
            }
        }
    
    func addItemToCatalog(item: Item) {
            warehouseInventory.append(item)
            // Convert Item to dictionary for Firestore
            let itemDict = [
                "name": item.namePublic,
                "manufacturer": item.manufacturerPublic,
                "cost": item.costPublic ?? nil,
                "weight": item.weightPublic ?? 0,
                "receiveDate": item.receiveDatePublic ?? Date(),
                "supplier": item.supplierPublic ?? "",
                "itemPictureURL": item.itemPictureURLPublic ?? ""
            ] as [String : Any]
            // Add item to Firestore
            db.collection("Item Catalog").addDocument(data: itemDict) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added with ID:")
                }
            }
        }
    
    // Method to add an item to the truck inventory
    func addItemToTruck(item: Item, truck: Truck) {
        truckInventory.append(item) // Add to local array
        // Convert Item to dictionary for Firestore
        let itemDict = [
            "name": item.namePublic,
            "manufacturer": item.manufacturerPublic,
            "cost": item.costPublic ?? nil,
            "weight": item.weightPublic ?? 0,
            "receiveDate": item.receiveDatePublic ?? Date(),
            "supplier": item.supplierPublic ?? "",
            "itemPictureURL": item.itemPictureURLPublic ?? ""
        ] as [String : Any]
        
    
        let truckDocumentRef = db.collection("Vehicles").document(truck.vehicleNumberPublic)
        
        // Add item to Firestore
        truckDocumentRef.collection("Truck Inventory").addDocument(data: itemDict) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Item added to truck with ID: \(truck.vehicleNumberPublic)")
            }
        }
    }

    func loadItemsFromWarehouse(completion: @escaping ([Item]) -> Void) {
      db.collection("Warehouse Inventory").getDocuments { (querySnapshot, error) in
        if let error = error {
          print("Error getting documents: \(error)")
          completion([])
        } else {
            
          var items: [Item] = []
          for document in querySnapshot!.documents {
              let itemName = document.data()["name"] as? String ?? ""
              let itemManufacturer = document.data()["manufacturer"] as? String ?? ""
              let itemCost = document.data()["cost"] as? Double
              let itemWeight = document.data()["weight"] as? Double
              let itemReceiveDate = document.data()["receiveDate"] as? Date
              let itemSupplier = document.data()["supplier"] as? String ?? ""
              let itemPictureURL = document.data()["itemPictureURL"] as? String ?? ""
              let item = Item(name: itemName, manufacturer: itemManufacturer, cost: itemCost, weight: itemWeight, receiveDate: itemReceiveDate, supplier: itemSupplier, itemPictureURL: itemPictureURL)
            items.append(item)
          }
          completion(items)
        }
      }
    }

    // Method to load items from the truck inventory for a specific truck
    func loadItemsFromTruck(truck: Truck, completion: @escaping ([Item]) -> Void) {
      let truckDocumentRef = db.collection("Vehicles").document(truck.vehicleNumberPublic)
      truckDocumentRef.collection("Truck Inventory").getDocuments { (querySnapshot, error) in
        if let error = error {
          print("Error getting documents: \(error)")
          completion([])
        } else {
          var items: [Item] = []
            for document in querySnapshot!.documents {
                let itemName = document.data()["name"] as? String ?? ""
                let itemManufacturer = document.data()["manufacturer"] as? String ?? ""
                let itemCost = document.data()["cost"] as? Double
                let itemWeight = document.data()["weight"] as? Double
                let itemReceiveDate = document.data()["receiveDate"] as? Date
                let itemSupplier = document.data()["supplier"] as? String ?? ""
                let itemPictureURL = document.data()["itemPictureURL"] as? String ?? ""
                let item = Item(name: itemName, manufacturer: itemManufacturer, cost: itemCost, weight: itemWeight, receiveDate: itemReceiveDate, supplier: itemSupplier, itemPictureURL: itemPictureURL)
              items.append(item)
            }
          completion(items)
        }
      }
    }

    // Method to load items from the catalog
    func loadItemsFromCatalog(completion: @escaping ([Item]) -> Void) {
      db.collection("Item Catalog").getDocuments { (querySnapshot, error) in
        if let error = error {
          print("Error getting documents: \(error)")
          completion([])
        } else {
          var items: [Item] = []
            for document in querySnapshot!.documents {
                let itemName = document.data()["name"] as? String ?? ""
                let itemManufacturer = document.data()["manufacturer"] as? String ?? ""
                let itemCost = document.data()["cost"] as? Double
                let itemWeight = document.data()["weight"] as? Double
                let itemReceiveDate = document.data()["receiveDate"] as? Date
                let itemSupplier = document.data()["supplier"] as? String ?? ""
                let itemPictureURL = document.data()["itemPictureURL"] as? String ?? ""
                let item = Item(name: itemName, manufacturer: itemManufacturer, cost: itemCost, weight: itemWeight, receiveDate: itemReceiveDate, supplier: itemSupplier, itemPictureURL: itemPictureURL)
              items.append(item)
            }
          completion(items)
        }
      }
    }
    // You can add more methods as needed, for example, to remove items, list items, etc.
}
