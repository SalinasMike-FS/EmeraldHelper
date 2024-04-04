//
//  FirestoreHelper.swift
//
//  Created by Natividad Michael Salinas II on 2/10/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage




class FirestoreHelper{
    
    
    let db = Firestore.firestore()
    
    
    func registerUser(user: User, completion: @escaping (Bool, Error?) -> Void) {
            guard let email = user.emailPublic, let password = user.passwordPublic else {
                completion(false, nil) // Email or password is nil
                return
            }
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    completion(false, error)
                    return
                }
                
                guard let uid = authResult?.user.uid else {
                    completion(false, nil) // UID not found
                    return
                }
                
                // Set the UID for the user
                user.uidPublic = uid
                
                // Store user profile in Firestore
                self.storeUserProfile(user: user) { success in
                    completion(success, nil)
                }
            }
        }
    
    private func storeUserProfile(user: User, completion: @escaping (Bool) -> Void) {
            guard let uid = user.uidPublic else {
                completion(false)
                return
            }
            
            let userDict: [String: Any?] = [
                "firstName": user.firstNamePublic,
                "lastName": user.lastNamePublic,
                "address": user.addressPublic,
                "email": user.emailPublic,
                // More fields can be added as needed
            ]
            
        db.collection("users").document(uid).setData(userDict as [String : Any]) { error in
                completion(error == nil)
            }
        }
    
    
    func loginUser(email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let uid = authResult?.user.uid else {
                completion(nil, NSError(domain: "FirebaseAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve UID"]))
                return
            }
            
            // Fetch user profile after successful login
            self.fetchUserProfile(uid: uid, completion: completion)
        }
    }

    
    
    func fetchUserProfile(uid: String, completion: @escaping (User?, Error?) -> Void) {
        db.collection("users").document(uid).getDocument { documentSnapshot, error in
            guard let documentSnapshot = documentSnapshot, documentSnapshot.exists else {
                completion(nil, error)
                return
            }
            
            let data = documentSnapshot.data()
            let user = User(
                firstName: data?["firstName"] as? String,
                lastName: data?["lastName"] as? String,
                address: data?["address"] as? String,
                email: data?["email"] as? String
                // The UID and password are not fetched from Firestore for security reasons
            )
            
            // Attempt to load the profile picture URL
            self.loadProfilePictureURL(uid: uid) { url in
                // Convert URL to String before assigning
                user.profilePictureURLPublic = url?.absoluteString
                completion(user, nil)
            }
        }
    }


    func loadProfilePictureURL(uid: String, completion: @escaping (URL?) -> Void) {
        let storageRef = Storage.storage().reference().child("profilePictures/\(uid).jpg")
        
        storageRef.downloadURL { url, error in
            guard let downloadURL = url else {
                print("Could not fetch download URL: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            completion(downloadURL)
        }
    }

    func uploadProfilePicture(uid: String, image: UIImage, completion: @escaping (URL?) -> Void) {
        let storageRef = Storage.storage().reference().child("profilePictures/\(uid).jpg")
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(nil)
            return
        }
        
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            storageRef.downloadURL { url, _ in
                completion(url)
            }
        }
    }

    
    
}
