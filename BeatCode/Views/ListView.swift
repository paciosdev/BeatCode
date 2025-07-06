//
//  ListView.swift
//  BeatCode
//
//  Created by Francesco Paciello on 06/07/25.
//

import SwiftUI

struct ListView: View {
    @State private var itemStore: ItemStore
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    
    init(itemStore: ItemStore) {
        self.itemStore = itemStore
    }
    
    var body: some View {
        NavigationStack {
            List(itemStore.filteredItems) { item in
                NavigationLink(destination: DetailView(item: item, itemStore: itemStore)) {
                    HStack {
                        Text(item.title)
                            .accessibilityAddTraits(.isHeader)
                        
                        Spacer()
                        
                        Button(action: {
                            if reduceMotion {
                                itemStore.toggleFavorite(for: item)
                            } else {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                    itemStore.toggleFavorite(for: item)
                                }
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
                        .scaleEffect(reduceMotion ? 1.0 : (item.isFavorite ? 1.1 : 1.0))
                        .animation(reduceMotion ? nil : .spring(response: 0.3, dampingFraction: 0.7), value: item.isFavorite)
                        .accessibilityLabel(item.isFavorite ? "Remove from favorites" : "Add to favorites")
                        .accessibilityHint("Double tap to \(item.isFavorite ? "remove this item from" : "add this item to") your favorites")
                        .accessibilityAddTraits(.isButton)
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("\(item.title), \(item.isFavorite ? "favorited" : "not favorited")")
                    .accessibilityHint("Double tap to view details")
                    .accessibilityAction(named: item.isFavorite ? "Remove from favorites" : "Add to favorites") {
                        if reduceMotion {
                            itemStore.toggleFavorite(for: item)
                        } else {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                itemStore.toggleFavorite(for: item)
                            }
                        }
                    }
                }
                .accessibilityElement(children: .contain)
            }
            .searchable(text: $itemStore.searchText, prompt: "Search items...")
            .navigationTitle("TestApp")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button(action: {
                            if reduceMotion {
                                itemStore.toggleFavoritesFilter()
                            } else {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    itemStore.toggleFavoritesFilter()
                                }
                            }
                        }) {
                            Label(
                                itemStore.showFavoritesOnly ? "Show All Items" : "Show Only Favorites",
                                systemImage: itemStore.showFavoritesOnly ? "heart.slash" : "heart.fill"
                            )
                        }
                        .accessibilityHint("Toggles between showing all items and only favorited items")
                        
                        if itemStore.showFavoritesOnly || !itemStore.searchText.isEmpty {
                            Divider()
                            
                            Button(action: {
                                if reduceMotion {
                                    itemStore.clearFilters()
                                } else {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        itemStore.clearFilters()
                                    }
                                }
                            }) {
                                Label("Clear All Filters", systemImage: "xmark.circle")
                            }
                            .accessibilityHint("Removes all active filters and shows all items")
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.title2)
                            .foregroundStyle(itemStore.showFavoritesOnly ? .blue : .primary)
                    }
                    .accessibilityLabel("Filter options")
                    .accessibilityHint("Opens menu with filtering options")
                    .accessibilityAddTraits(.isButton)
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
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel(itemStore.showFavoritesOnly ? "No favorites found" : "No search results")
                    .accessibilityValue(itemStore.showFavoritesOnly ? 
                        "Add items to favorites by tapping the heart icon next to any item" : 
                        itemStore.searchText.isEmpty ? "No items are currently available" : "Try searching with different keywords"
                    )
                }
            }
        }
    }
}

#Preview {
    ListView(itemStore: ItemStore())
}
