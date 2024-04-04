//
//  AddVehicleView.swift
//  Emerlad Helper
//
//  Created by Natividad Michael Salinas II on 3/9/24.
//

import SwiftUI
import FirebaseFirestore

struct AddVehicleView: View {
    @State private var vehicleNumber = ""
    @State private var licensePlateNumber = ""
    @State private var registrationExpiration = ""
    @State private var safetyInspection = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Vehicle Information")) {
                    TextField("Vehicle Number", text: $vehicleNumber)
                    TextField("License Plate Number", text: $licensePlateNumber)
                    TextField("Registration Expiration", text: $registrationExpiration)
                    TextField("Safety Inspection Date", text: $safetyInspection)
                }
                
                Button("Add Vehicle") {
                    addVehicle()
                }
            }
            .navigationBarTitle("Add Vehicle", displayMode: .inline)
        }
    }
    
    private func addVehicle() {
        let vehicle = Vehicle(vehicleNumber: vehicleNumber, licensePlateNumber: licensePlateNumber, registrationExpiration: registrationExpiration, safetyInspection: safetyInspection)
        vehicle.addVehicle(vehicle: vehicle)
    }
}

struct AddVehicleView_Previews: PreviewProvider {
    static var previews: some View {
        AddVehicleView()
    }
}
