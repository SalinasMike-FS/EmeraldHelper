//
//  SwiftUIView.swift
//  Emerlad Helper
//
//  Created by Natividad Michael Salinas II on 3/7/24.
//

import SwiftUI

struct SwiftUIView: View {
    var inventory: Inventory
    
    var body: some View {
        VStack{
            
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an example item or items
        let exampleItems = [Item(name: "Capacitor", manufacturer: "Titan", cost: 15.35)]
        // Pass the example items to Inventory and then to SwiftUIView
       
    }
}
