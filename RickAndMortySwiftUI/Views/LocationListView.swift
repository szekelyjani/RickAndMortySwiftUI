//
//  LocationListView.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 24..
//

import SwiftUI

struct LocationListView: View {
    @StateObject private var vm = LocationListViewViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.locations) { location in
                    NavigationLink {
                        LocationListCell(location: location)
                    } label: {
                        LocationListCell(location: location)
                    }
                }
                switch vm.loadingState {
                case .na:
                    if #available(iOS 17.0, *) {
                        ContentUnavailableView.search
                    } else {
                        EmptyView()
                    }
                case .loading:
                    ProgressView()
                        .frame(width: 100, height: 100)
                case .finished:
                    if vm.nextPageUrl != nil {
                        Color.gray.frame(height: 100)
                            .onAppear {
                                Task {
                                    await vm.getMoreLocations()
                                }
                            }
                    }
                default:
                    EmptyView()
                }
            }
            .navigationTitle("Locations")
            .listStyle(.automatic)
            .searchable(
                text: $vm.searchText,
                placement: .automatic,
                prompt: "Search Locations"
            )
        }
        .task {
            await vm.getAllLocations()
        }
        .onSubmit(of: .search) {
            Task {
                await vm.search()
            }
        }
    }
}

#Preview {
    LocationListView()
}
