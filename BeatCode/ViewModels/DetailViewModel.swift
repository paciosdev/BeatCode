//
//  DetailViewModel.swift
//  BeatCode
//
//  Created by Francesco Paciello on 06/07/25.
//

import Foundation

@Observable
class DetailViewModel {
    private let itemStore: ItemStore
    private let itemId: UUID
    
    var item: Item? {
        itemStore.getItem(by: itemId)
    }
    
    init(item: Item, itemStore: ItemStore) {
        self.itemId = item.id
        self.itemStore = itemStore
    }
    
    func toggleFavorite() {
        if let item = item {
            itemStore.toggleFavorite(for: item)
        }
    }
}