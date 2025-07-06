//
//  DetailView.swift
//  BeatCode
//
//  Created by Francesco Paciello on 06/07/25.
//

import SwiftUI

struct DetailView: View {
    let item: Item
    private let itemStore: ItemStore
    
    init(item: Item, itemStore: ItemStore) {
        self.item = item
        self.itemStore = itemStore
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(item.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button(action: {
                itemStore.toggleFavorite(for: item)
            }) {
                HStack {
                    Image(systemName: item.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(item.isFavorite ? .red : .gray)
                        .font(.title)
                        .frame(width: 44, height: 44)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                    Text(item.isFavorite ? "Remove from Favorites" : "Add to Favorites")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        DetailView(item: Item(title: "Test Item"), itemStore: ItemStore())
    }
}