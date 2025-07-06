//
//  Item.swift
//  BeatCode
//
//  Created by Francesco Paciello on 06/07/25.
//

import Foundation

struct Item: Identifiable {
    let id = UUID()
    let title: String
    var isFavorite: Bool = false
}