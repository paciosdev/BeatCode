//
//  ListView.swift
//  BeatCode
//
//  Created by Francesco Paciello on 06/07/25.
//

import SwiftUI

struct ListView: View {
    @State private var itemStore: ItemStore
    
    init(itemStore: ItemStore) {
        self.itemStore = itemStore
    }
    
    var body: some View {
        NavigationStack {
            List(itemStore.filteredItems) { item in
                NavigationLink(destination: DetailView(item: item, itemStore: itemStore)) {
                    HStack {
                        Text(item.title)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                itemStore.toggleFavorite(for: item)
                            }
                        }) {
                            Image(systemName: item.isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(item.isFavorite ? .red : .gray)
                                .font(.title2)
                                .frame(width: 44, height: 44)
                                .background(Color.gray.opacity(0.1))
                                .clipShape(Circle())
                        }
                        .buttonStyle(PlainButtonStyle())
                        .scaleEffect(item.isFavorite ? 1.1 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: item.isFavorite)
                    }
                }
            }
            .searchable(text: $itemStore.searchText, prompt: "Search items...")
            .navigationTitle("TestApp")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                itemStore.toggleFavoritesFilter()
                            }
                        }) {
                            Label(
                                itemStore.showFavoritesOnly ? "Show All Items" : "Show Only Favorites",
                                systemImage: itemStore.showFavoritesOnly ? "heart.slash" : "heart.fill"
                            )
                        }
                        
                        if itemStore.showFavoritesOnly || !itemStore.searchText.isEmpty {
                            Divider()
                            
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    itemStore.clearFilters()
                                }
                            }) {
                                Label("Clear All Filters", systemImage: "xmark.circle")
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.title2)
                            .foregroundStyle(itemStore.showFavoritesOnly ? .blue : .primary)
                    }
                }
            }
            .overlay {
                if itemStore.filteredItems.isEmpty {
                    ContentUnavailableView(
                        itemStore.showFavoritesOnly ? "No Favorites" : "No Results",
                        systemImage: itemStore.showFavoritesOnly ? "heart.slash" : "magnifyingglass",
                        description: Text(itemStore.showFavoritesOnly ? 
                            "Add items to favorites by tapping the heart icon" : 
                            itemStore.searchText.isEmpty ? "No items available" : "Try a different search term"
                        )
                    )
                }
            }
        }
    }
}

#Preview {
    ListView(itemStore: ItemStore())
}
