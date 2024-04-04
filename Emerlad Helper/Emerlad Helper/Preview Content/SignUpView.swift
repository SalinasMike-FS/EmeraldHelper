//
//  SignUpView.swift

//
//  Created by Natividad Michael Salinas II on 2/10/24.
//

import Foundation
import UIKit
import SwiftUI
import GooglePlaces

struct SignUpView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var address = ""
    @State private var email = ""
    @State private var password = ""
    @State private var type = "Manager" // Default value
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var profileImage: Image?
    @State private var addressSuggestions: [String] = [] // Holds address suggestions
    @State private var showingAutocomplete = false
    

        // Instantiate your location helper
        private var locationHelper = Location()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information").bold()) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    
                  
                    TextField("Address", text: $address)
//                        .onTapGesture {
//                            self.showingAutocomplete = true
//                        }
//                    
//                    ForEach(addressSuggestions, id: \.self) { suggestion in
//                                            Text(suggestion)
//                                                .onTapGesture {
//                                                    // User selects an address suggestion
//                                                    self.address = suggestion
//                                                    self.addressSuggestions = [] // Clear suggestions
//                                                }
//                                        }
                    
                }
                
                Section(header: Text("Account Information").bold()) {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                    Picker("Job Type", selection: $type) {
                        Text("Manager").tag("Manager")
                        Text("Service").tag("Service")
                        Text("Maintenance").tag("Maintenance")
                    }
                }
                
                Section(header: Text("Profile Picture").bold()) {
                    ZStack {
                        Rectangle().fill(profileImage == nil ? Color.secondary : Color.clear)
                            .frame(height: 200)
                        
                        if let profileImage = profileImage {
                            profileImage
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
               
             
            
                Button("Sign Up")
                {
                    signUp()
                }
            }
            .navigationBarTitle("Sign Up", displayMode: .inline)
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
            .sheet(isPresented: $showingAutocomplete){
                AutocompleteView(text: $address, isPresented: $showingAutocomplete)
            }
                
        }
    }
    
    func fetchAddressSuggestions(query: String) {
        locationHelper.searchPlaces(query: query) { places, error in
            if let error = error {
                print("Error fetching address suggestions: \(error.localizedDescription)")
                self.addressSuggestions = []
                return
            }

            // Map the received places to their names or formatted addresses
            self.addressSuggestions = places?.compactMap { $0.name } ?? [] // Use $0.formattedAddress for addresses
        }
    }

    
    func signUp() {
        // Input validation remains the same
        guard !firstName.isEmpty, !lastName.isEmpty, !address.isEmpty, !email.isEmpty, !password.isEmpty, let inputImage = inputImage else {
            print("All fields and profile picture are required.")
            return
        }

        // Create a new User instance with the form data
        let newUser = User(firstName: firstName, lastName: lastName, address: address, email: email, password: password, type: type)
        
        // Instantiate FirestoreHelper and call registerUser
        let helper = FirestoreHelper()
        helper.registerUser(user: newUser) { success, error in
            if let error = error {
                print("Error registering user: \(error.localizedDescription)")
                return
            }
            
            if success {
                // Upon successful registration, upload the profile picture
                helper.uploadProfilePicture(uid: newUser.uidPublic!, image: inputImage) { url in
                    guard let url = url else {
                        print("Failed to upload profile picture.")
                        return
                    }
                    // Update the user's profilePictureURL
                    newUser.profilePictureURLPublic = url.absoluteString
                    
                    print("User registered successfully with profile picture.")
                }
            }
        }
    }

    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
        // Here, you would upload the image to Firebase Storage and save the URL
    }
}



struct AutocompleteView: UIViewControllerRepresentable {
    
    @Binding var text: String
    @Binding var isPresented: Bool
    
    class Coordinator: NSObject, UINavigationControllerDelegate, GMSAutocompleteViewControllerDelegate {
        @Binding var text: String
        var parent: AutocompleteView
        
        init(text: Binding<String>, parent: AutocompleteView) {
            _text = text
            self.parent = parent
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            text = place.name ?? ""
            dismiss()
            parent.dismissAutocomplete()
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("Error: \(error.localizedDescription)")
            parent.dismissAutocomplete()
        }
        
        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            dismiss()
            parent.dismissAutocomplete()
        }
        
        func dismiss() {
                    parent.isPresented = false
                }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, parent: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<AutocompleteView>) -> GMSAutocompleteViewController {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator
        return autocompleteController
    }
    
    func updateUIViewController(_ uiViewController: GMSAutocompleteViewController, context: UIViewControllerRepresentableContext<AutocompleteView>) {
        // You can update the filter or other settings here if needed
    }
    
    private func dismissAutocomplete() {
        self.isPresented = false
    }
}



#Preview {
    SignUpView()
}
