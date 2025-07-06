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
            
            Text("Welcome to \(item.title)")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
         
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    itemStore.toggleFavorite(for: item)
                }) {
                    Image(systemName: item.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(item.isFavorite ? .red : .gray)
                        .font(.title2)
                        .frame(width: 44, height: 44)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                }
                .buttonStyle(PlainButtonStyle())
            }
        })
        .padding()
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        DetailView(item: Item(title: "Test Item"), itemStore: ItemStore())
    }
}
