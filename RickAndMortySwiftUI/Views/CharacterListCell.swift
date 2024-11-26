//
//  CharacterListCell.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 25..
//

import SwiftUI

struct CharacterListCell: View {
    let character: RMCharacter
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .clipShape(Circle())
            
            /*@START_MENU_TOKEN@*/Text(character.name)/*@END_MENU_TOKEN@*/
                .font(.title3)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
        }
    }
}

#Preview {
    CharacterListCell(character: RMCharacter.Rick)
}
