//
//  ListViewModel.swift
//  BeatCode
//
//  Created by Francesco Paciello on 06/07/25.
//

import Foundation

@Observable
class ListViewModel {
    private let itemStore: ItemStore
    
    var items: [Item] {
        itemStore.items
    }
    
    init(itemStore: ItemStore) {
        self.itemStore = itemStore
    }
    
    func toggleFavorite(for item: Item) {
        itemStore.toggleFavorite(for: item)
    }
}