//
//  CharacterListCell.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 25..
//

import SwiftUI

struct CharacterListCell: View {
    @State var image: UIImage? = nil
    let character: RMCharacter
    
    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
            } else {
                Image(.avatar)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
            }
            
            /*@START_MENU_TOKEN@*/Text(character.name)/*@END_MENU_TOKEN@*/
                .font(.title3)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
        }
        .task {
            self.image = await NetworkManager.shared.downloadImage(from: character.image)
        }
    }
}

#Preview {
    CharacterListCell(character: RMCharacter.Rick)
}
