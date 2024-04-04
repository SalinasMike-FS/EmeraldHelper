//
//  AddItemView.swift
//  Emerlad Helper
//
//  Created by Natividad Michael Salinas II on 3/8/24.
//
import SwiftUI
import FirebaseFirestore

struct AddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var manufacturer = ""
    @State private var cost: Double?
    @State private var weight: Double?
    @State private var receiveDate: Date?
    @State private var supplier: String?
    @State private var inputImage: UIImage?
    @State private var itemImage: Image?
    @State private var showingImagePicker = false
    @State private var addToWarehouse = true
    @State private var addToCatalog = true /// New State variable to decide destination
    @State private var selectedCategory : Category = .Misc
    
    @State private var showAlert = false
       @State private var alertMessage = ""
       @State private var alertTitle = ""
    
    var inventory = Inventory()
    var assignedTrucku = Truck(vehicleNumber: "29", licensePlateNumber: "Plate23", registrationExpiration: "04/24/25", safetyInspection: "04/24")

    private func isTechnicianAssignedToTruck() -> Bool {
        // Example condition check
        return true
    }
    
    private func addedToMiscCategory() -> Bool{
        
        return true
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Item Information").bold()) {
                    TextField("Name", text: $name)
                    TextField("Manufacturer", text: $manufacturer)
                    TextField("Cost after tax", value: $cost, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                    
                    
                }
                
                Section( header: Text("Category")){
                    Picker("Select Category", selection: $selectedCategory) {
                        Text("Adhesives").tag(Category.Adhesives)
                        Text("Misc").tag(Category.Misc)
                        Text("Air Elmination").tag(Category.AirElimination)
                        Text("Belts").tag(Category.Belts)
                        Text("Brazing").tag(Category.Brazing)
                        Text("Capacitors").tag(Category.Capacitors)
                        Text("Chemicals, Cleaners").tag(Category.ChemicalsCleaners)
                        Text("Condensate").tag(Category.Condensate)
                        Text("Contactors").tag(Category.Contactors)
                        Text("Control Boards").tag(Category.ControlBoards)
                        Text("Filter Driers").tag(Category.Driers)
                        Text("Duct").tag(Category.Duct)
                        Text("Electrcial").tag(Category.Electrical)
                        Text("Filters").tag(Category.Filters)
                        Text("Gas Valves").tag(Category.GasValves)
                        Text("Gaskets").tag(Category.Gaskets)
                        Text("IAQ").tag(Category.IAQ)
                        Text("Ignitors").tag(Category.Ignitors)
                        Text("Metering Devices").tag(Category.MeteringDevice)
                        Text("Motors").tag(Category.Motors)
                        Text("Other").tag(Category.Other)
                        Text("Piping").tag(Category.Piping)
                        Text("Safties").tag(Category.Safties)
                        
                    }
                }
                
                // Optionally add a destination choice if a technician has a truck
                Section(header: Text("Add to").bold()) {
                if isTechnicianAssignedToTruck() {
                        Picker("Destination", selection: $addToWarehouse) {
                            Text("Warehouse").tag(true)
                            Text("Truck").tag(false)
                            Text("None").tag(false)
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    
                    
                    else{
                           Toggle(isOn: $addToCatalog, label: {
                               Text("Catalog")
                       })
                   }
                    
                }
                
                if isTechnicianAssignedToTruck(){
                    
                           Toggle(isOn: $addToCatalog, label: {
                               Text("Catalog")
                       })
                }
               
                Section(header: Text("Item Picture").bold()) {
                    ZStack {
                        Rectangle()
                            .fill(itemImage == nil ? Color.secondary : Color.clear)
                            .frame(height: 200)

                        if let itemImage = itemImage {
                            itemImage
                                .resizable()
                                .scaledToFit()
                        } else {
                            Text("Tap to select a picture")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                    }
                    .onTapGesture {
                        showingImagePicker = true
                    }
                }

               
               
            }
            .navigationBarTitle("Add Item", displayMode: .automatic)
            .navigationBarItems(leading: cancelButton, trailing: submitButton)
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
            .alert(isPresented: $showAlert) {
                            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
         
        }
    
    }
    
    private var cancelButton: some View {
            Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }
        }
        
        private var submitButton: some View {
            Button("Submit") {
                addItem()
            }
        }
    
    private func getAssignedTruck() -> Truck {
           
           return assignedTrucku  //TODO: correct the typo
       }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        itemImage = Image(uiImage: inputImage)
        //TODO: Implement the Firebase logic
    }
    
    func addItem() {
            let newItem = Item(name: name, manufacturer: manufacturer, cost: cost, weight: weight, receiveDate: receiveDate, supplier: supplier, itemPictureURL: nil) // Adjust as needed
            
            if addToWarehouse {
                inventory.addItemToWarehouse(item: newItem)
                showAlert(title: "Success", message: "Item added to warehouse successfully")
                inventory.addItemToCatalog(item: newItem)
                navigateToCategoryView()
            } else if addToCatalog {
                inventory.addItemToCatalog(item: newItem)
                showAlert(title: "Success", message: "Item added to catalog successfully")
                navigateToCategoryView()
            } else {
                let assignedTruck = getAssignedTruck()
                inventory.addItemToTruck(item: newItem, truck: assignedTruck)
                showAlert(title: "Success", message: "Item added to truck successfully")
                navigateToCategoryView()
            }
        }
    

       
       private func navigateToCategoryView() {
           // Navigate to ItemCategoryView
           presentationMode.wrappedValue.dismiss()
       }
       
       private func showAlert(title: String, message: String) {
           alertTitle = title
           alertMessage = message
           showAlert = true
       }
}

enum Category: String, CaseIterable, Identifiable {
    case Misc, Adhesives, Filters, Belts, Brazing, Capacitors, ChemicalsCleaners, Condensate, Contactors, ControlBoards, Duct, Electrical, Driers, Gaskets, GasValves, Ignitors, PressureSwitches, Thermocouples, MeteringDevice, IAQ, Piping, Humidifier, Pumps, AirElimination, Safties, Other, Motors
    
    var id: Self { self }
}
                     
                              
    struct ImagePicker: UIViewControllerRepresentable {
        @Binding var image: UIImage?
        
        func makeUIViewController(context: Context) -> some UIViewController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            return picker
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
            let parent: ImagePicker
            
            init(_ parent: ImagePicker) {
                self.parent = parent
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let uiImage = info[.originalImage] as? UIImage {
                    parent.image = uiImage
                }
                picker.dismiss(animated: true)
            }
        }
    }

                              
                              

#Preview {
    AddItemView()
}
