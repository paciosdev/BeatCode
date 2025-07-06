//
//  ItemStore.swift
//  BeatCode
//
//  Created by Francesco Paciello on 06/07/25.
//

import Foundation

@Observable
class ItemStore {
    var items: [Item] = []
    var searchText: String = ""
    var showFavoritesOnly: Bool = false
    
    var filteredItems: [Item] {
        var filtered = items
        
        if showFavoritesOnly {
            filtered = filtered.filter { $0.isFavorite }
        }
        
        if !searchText.isEmpty {
            filtered = filtered.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
        
        return filtered
    }
    
    init() {
        items = (1...10).map { Item(title: "Cell number \($0)") }
    }
    
    func toggleFavorite(for item: Item) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isFavorite.toggle()
        }
    }
    
    func getItem(by id: UUID) -> Item? {
        return items.first { $0.id == id }
    }
    
    func toggleFavoritesFilter() {
        showFavoritesOnly.toggle()
    }
    
    func clearFilters() {
        showFavoritesOnly = false
        searchText = ""
    }
}
