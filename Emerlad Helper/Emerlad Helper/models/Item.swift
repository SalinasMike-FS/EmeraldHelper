//
//  Item.swift
//  Emerlad Helper
//
//  Created by Natividad Michael Salinas II on 3/7/24.
//

import Foundation
import SwiftUI
import FirebaseFirestore


class Item{
    
    private var name = ""
    private var manufacturer = ""
    private var cost : Double?
    private var weight : Double?
    private var receiveDate: Date?
    private var supplier : String?
    private var itemPictureURL: String?
    
    init(name: String = "", manufacturer: String = "", cost: Double?, weight: Double? = nil, receiveDate: Date? = nil, supplier: String? = nil, itemPictureURL: String? = nil) {
        self.name = name
        self.manufacturer = manufacturer
        self.cost = cost
        self.weight = weight
        self.receiveDate = receiveDate
        self.supplier = supplier
        self.itemPictureURL = itemPictureURL
    }
    
    
    var namePublic: String{
        get{
            return self.name
        }
        set{
            self.name = newValue
        }
    }
    
    var manufacturerPublic: String{
        get{
            return self.manufacturer
        }
        set{
            self.manufacturer = newValue
        }
    }
    
    var costPublic: Double?{
        get{
            return self.cost
        }
        set{
            self.cost = newValue
        }
    }
    
    var weightPublic: Double?{
        get{
            return self.weight
        }
        set{
            self.weight = newValue
        }
    }
    
    var receiveDatePublic: Date?{
        get{
            return self.receiveDate
        }
        set{
            self.receiveDate = newValue
        }
    }
    
    var supplierPublic: String?{
        get{
            return self.supplier
        }
        set{
            self.supplier = newValue
        }
    }
    
    var itemPictureURLPublic: String?{
        get{
            return self.itemPictureURL
        }
        set{
            self.itemPictureURL = newValue
        }
    }
    
}


class Tool : Item {
    

}



