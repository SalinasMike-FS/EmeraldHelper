//
//  Vehicle.swift
//  Emerlad Helper
//
//  Created by Natividad Michael Salinas II on 3/7/24.
//

import Foundation
import FirebaseFirestore



class Vehicle{
    
    let db = Firestore.firestore()
    
    private var vehicleNumber = ""
    private var licensePlateNumber = ""
    private var registrationExpiration = ""
    private var safetyInspection = ""
    private var inventory  : Inventory?
    
    
    
    init(vehicleNumber: String = "", licensePlateNumber: String = "", registrationExpiration: String = "", safetyInspection: String = "", inventory: Inventory? = nil) {
        self.vehicleNumber = vehicleNumber
        self.licensePlateNumber = licensePlateNumber
        self.registrationExpiration = registrationExpiration
        self.safetyInspection = safetyInspection
        self.inventory = inventory
    }
    
    var vehicleNumberPublic: String{
        get{
            return self.vehicleNumber
        }
        set{
            self.vehicleNumber = newValue
        }
    }
    
    var licensePlateNumberPublic: String{
        get{
            return self.licensePlateNumber
        }
        set{
            self.licensePlateNumber = newValue
        }
    }
    
    var registrationExpirationPublic: String{
        get{
            return self.registrationExpiration
        }
        set{
            self.registrationExpiration = newValue
        }
    }
    
    
    var safetyInspectionPublic: String{
        get{
            return self.safetyInspection
        }
        set{
            self.safetyInspection = newValue
        }
    }
    
    var inventoryPublic: Inventory?{
        get{
            return self.inventory
        }
        set{
            self.inventory = newValue
        }
    }
    
    func addVehicle(vehicle: Vehicle) {
        var vehicleList: [Vehicle] = []
            vehicleList.append(vehicle) // Add to local array
            // Convert Item to dictionary for Firestore
            let vehicleDict = [
                "Number": vehicle.vehicleNumberPublic,
                "License Plate": vehicle.licensePlateNumberPublic,
                "Registration Expiration Date": vehicle.registrationExpirationPublic,
                "Safety Inspection": vehicle.safetyInspectionPublic,
                "Inventory": vehicle.inventoryPublic ?? ""
            ] as [String : Any]
            // Add item to Firestore
            db.collection("Vehicles").addDocument(data: vehicleDict) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added with ID:")
                }
            }
        }
    
}


class Truck: Vehicle {
    
}

class Sedan: Vehicle{
    
}

