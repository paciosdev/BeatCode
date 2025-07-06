//
//  ContentView.swift
//  BeatCode
//
//  Created by Francesco Paciello on 06/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var itemStore = ItemStore()
    
    var body: some View {
        ListView(itemStore: itemStore)
    }
}

#Preview {
    ContentView()
}
