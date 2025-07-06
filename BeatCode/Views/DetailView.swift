//
//  DetailView.swift
//  BeatCode
//
//  Created by Francesco Paciello on 06/07/25.
//

import SwiftUI

struct DetailView: View {
    private let viewModel: DetailViewModel
    
    init(item: Item, itemStore: ItemStore) {
        self.viewModel = DetailViewModel(item: item, itemStore: itemStore)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            if let item = viewModel.item {
                Text(item.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Button(action: {
                    viewModel.toggleFavorite()
                }) {
                    HStack {
                        Image(systemName: item.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(item.isFavorite ? .red : .gray)
                        Text(item.isFavorite ? "Remove from Favorites" : "Add to Favorites")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
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