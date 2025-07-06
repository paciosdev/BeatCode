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
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    
    init(item: Item, itemStore: ItemStore) {
        self.item = item
        self.itemStore = itemStore
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Hero section
                VStack(spacing: 16) {
                    Image(systemName: "star.circle.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(.blue.gradient)
                        .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                        .accessibilityHidden(true)
                    
                    Text(item.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.center)
                        .accessibilityAddTraits(.isHeader)
                    
                    Text("Explore and enjoy this amazing content")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .accessibilityLabel("Description: Explore and enjoy this amazing content")
                }
                .padding(.top, 40)
                .accessibilityElement(children: .combine)
                .accessibilityLabel("\(item.title). Explore and enjoy this amazing content")
                .accessibilityAddTraits(.isHeader)
                
                VStack(spacing: 16) {
                    InfoCard(
                        icon: "heart.circle.fill",
                        title: item.isFavorite ? "Added to Favorites" : "Add to Favorites",
                        description: item.isFavorite ? "This item is in your favorites" : "Tap the heart to save this cell",
                        color: item.isFavorite ? .red : .gray
                    )
                }
                .padding(.horizontal)
                .accessibilityElement(children: .contain)
                .accessibilityLabel("Favorites status")
                
                Spacer(minLength: 50)
            }
        }
        .background(Color(.systemGroupedBackground))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    if reduceMotion {
                        itemStore.toggleFavorite(for: item)
                    } else {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            itemStore.toggleFavorite(for: item)
                        }
                    }
                }) {
                    Image(systemName: item.isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(item.isFavorite ? .red : .secondary)
                        .font(.title2)
                        .frame(width: 44, height: 44)
                        .background(.regularMaterial, in: Circle())
                        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                }
                .scaleEffect(reduceMotion ? 1.0 : (item.isFavorite ? 1.1 : 1.0))
                .animation(reduceMotion ? nil : .spring(response: 0.4, dampingFraction: 0.6), value: item.isFavorite)
                .accessibilityLabel(item.isFavorite ? "Remove from favorites" : "Add to favorites")
                .accessibilityHint("Double tap to \(item.isFavorite ? "remove this item from" : "add this item to") your favorites")
                .accessibilityAddTraits(.isButton)
            }
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityAction(named: item.isFavorite ? "Remove from favorites" : "Add to favorites") {
            if reduceMotion {
                itemStore.toggleFavorite(for: item)
            } else {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    itemStore.toggleFavorite(for: item)
                }
            }
        }
    }
}

struct InfoCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
                .frame(width: 32, height: 32)
                .accessibilityHidden(true)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .accessibilityAddTraits(.isHeader)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title). \(description)")
        .accessibilityAddTraits(.isStaticText)
    }
}

#Preview {
    NavigationView {
        DetailView(item: Item(title: "Test Item"), itemStore: ItemStore())
    }
}
