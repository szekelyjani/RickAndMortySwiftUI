//
//  LocationListCell.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 26..
//

import SwiftUI

struct LocationListCell: View {
    let location: RMLocation
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(location.name)
                .font(.title2)
            
            Text(location.type)
                .font(.title3)
            
            Text(location.dimension)
                .font(.footnote)
        }
    }
}

#Preview {
    LocationListCell(location: RMLocation.test_location)
}
