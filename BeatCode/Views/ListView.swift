//
//  ListView.swift
//  BeatCode
//
//  Created by Francesco Paciello on 06/07/25.
//

import SwiftUI

struct ListView: View {
    private let viewModel: ListViewModel
    private let itemStore: ItemStore
    
    init(itemStore: ItemStore) {
        self.itemStore = itemStore
        self.viewModel = ListViewModel(itemStore: itemStore)
    }
    
    var body: some View {
        NavigationStack {
            List(viewModel.items) { item in
                NavigationLink(destination: DetailView(item: item, itemStore: itemStore)) {
                    HStack {
                        Text(item.title)
                        Spacer()
                        Button(action: {
                            viewModel.toggleFavorite(for: item)
                        }) {
                            Image(systemName: item.isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(item.isFavorite ? .red : .gray)
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
