//
//  ItemsCatalogView.swift
//  Emerlad Helper
//
//  Created by Natividad Michael Salinas II on 3/12/24.
//


import SwiftUI

struct ItemsCatalogView: View {
    @Environment(\.presentationMode) var presentationMode
    let category: String // Category selected from the ItemCategoryView
    
    // Dummy data for item list
    let items: [String] = ["Item 1", "Item 2", "Item 3"] // Replace this with actual data
    
    @State private var showText = true
    
    var body: some View {
        NavigationView { // Add NavigationView wrapper
            VStack {
            
                
                if showText {
                    Text("Items in \(category)") // Display the selected category
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    self.showText = false
                                }
                            }
                        }
                    
                    // Display message indicating number of items found
                    if !items.isEmpty {
                        Text("\(items.count) items found:")
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        self.showText = false
                                    }
                                }
                            }
                    }
                }
                
                // List of items
                List(items, id: \.self) { item in
                    NavigationLink(destination: ItemDetailView(item: item)) {
                        Text(item)
                    }
                }
                
                // Edit and Delete buttons
                HStack {
                    Button(action: {
                        // Add action for edit button
                    }) {
                        Image(systemName: "pencil.circle")
                            .foregroundColor(.blue)
                            .font(.title)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Add action for delete button
                    }) {
                        Image(systemName: "trash.circle")
                            .foregroundColor(.red)
                            .font(.title)
                    }
                }
                .padding()
            }
            .navigationTitle("Items Catalog")
            .navigationBarBackButtonHidden(true)
          
        }
    }
}

struct ItemsCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsCatalogView(category: "Selected Category")
    }
}
