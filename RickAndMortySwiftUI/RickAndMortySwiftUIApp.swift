//
//  RickAndMortySwiftUIApp.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 24..
//

import SwiftUI

@main
struct RickAndMortySwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                CharacterListView()
                    .tabItem {
                        Label("Characters", systemImage: "person")
                    }
            }
        }
    }
}
