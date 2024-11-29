//
//  LocationListView.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 24..
//

import SwiftUI

struct LocationListView: View {
    var body: some View {
        TabView {
            CharacterListView()
                .tabItem {
                    Label("Characters", systemImage: "person")
                }
        }
    }
}

#Preview {
    LocationListView()
}
