//
//  ListView.swift
//  BeatCode
//
//  Created by Francesco Paciello on 06/07/25.
//

import SwiftUI

struct ListView: View {
    private let itemStore: ItemStore
    
    init(itemStore: ItemStore) {
        self.itemStore = itemStore
    }
    
    var body: some View {
        NavigationStack {
            List(itemStore.items) { item in
                NavigationLink(destination: DetailView(item: item, itemStore: itemStore)) {
                    HStack {
                        Text(item.title)
                        
                        Spacer()
                        
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
                }
            }
            .navigationTitle("TestApp")
        }
    }
}

#Preview {
    ListView(itemStore: ItemStore())
}
