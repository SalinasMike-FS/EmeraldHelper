//
//  Emerlad_HelperApp.swift
//  Emerlad Helper
//
//  Created by Natividad Michael Salinas II on 3/6/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GooglePlaces





class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

      GMSPlacesClient.provideAPIKey("AIzaSyCrUVPq3SUWBp118fkpMzLWI94oI-ZpxDc") 
    return true
  }
}
@main
struct Emerlad_HelperApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
      WindowGroup {
        NavigationView {
         ItemCategoryView()
            
        }
      }
    }
    
    
}
