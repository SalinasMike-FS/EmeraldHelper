//
//  User.swift
//  Emerlad Helper
//
//  Created by Natividad Michael Salinas II on 3/7/24.
//

import Foundation
import SwiftUI



class User{
    
    private var firstName: String?
    private var lastName: String?
    private var address: String?
    private var email: String?
    private var password: String?
    private var uid: String?
    private var type: String?
    private var profilePictureURL: String?
    
    init(firstName: String? = nil, lastName: String? = nil, address: String? = nil, email: String? = nil, password: String? = nil, uid: String? = nil, type: String? = nil, profilePictureURL: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.email = email
        self.password = password
        self.uid = uid
        self.type = type
        self.profilePictureURL = profilePictureURL
    }
    
    
    var firstNamePublic: String?{
        get{
            return self.firstName
        }
        set{
            self.firstName = newValue
        }
    }
    
    var lastNamePublic: String?{
        get{
            return self.lastName
        }
        set{
            self.lastName = newValue
        }
    }
    
    var addressPublic: String?{
        get{
            return self.address
        }
        set{
            self.address = newValue
        }
    }
    
    var emailPublic: String?{
        get{
            return self.email
        }
        set{
            self.email = newValue
        }
    }
    
    var passwordPublic: String?{
        get{
            return self.password
        }
        set{
            self.password = newValue
        }
    }
    
    var uidPublic: String?{
        get{
            return self.uid
        }
        set{
            self.uid = newValue
        }
    }
    var typePublic: String?{
        get{
            return self.type
        }
        set{
            self.type = newValue
        }
    }
    
    
    var profilePictureURLPublic: String?{
        get{
            return self.profilePictureURL
        }
        set{
            self.profilePictureURL = newValue
        }
    }
    

    
}

class Technician: User {

    private var truck: Truck?
    
    init(truck: Truck? = nil) {
        self.truck = truck
    }
    
    var truckPublic: Truck?{
        get{
            return self.truck
        }
        set{
            self.truck = newValue
        }
    }
    
}
