// ItemCategoryView.swift
// Emerlad Helper
//
// Created by Natividad Michael Salinas II on 3/16/24
//

import SwiftUI
import FirebaseFirestore


struct ItemCategoryView: View {
    let categories: [Category] = Category.allCases // Use the Category enum for generating categories dynamically
    @State private var isAddItemViewPresented = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            isAddItemViewPresented.toggle()
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.blue)
                                .padding()
                        }
                    }
                    
                    Label("Categories".uppercased(), systemImage: "")
                        .font(.title).bold()
                        .padding(.top)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                        ForEach(categories) { category in
                            NavigationLink(destination: ItemsCatalogView(category: category.rawValue)) {
                                ZStack(alignment: .center) {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(Color.gray.opacity(0.2))
                                        .frame(height: 150)
                                    
                                    Text(category.rawValue)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.automatic)
            .sheet(isPresented: $isAddItemViewPresented) { // Present AddItemView when isAddItemViewPresented is true
                AddItemView()}
            
        }
    }
}



struct ItemCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        ItemCategoryView()
            .previewLayout(.fixed(width: 400, height: 800))
    }
}
