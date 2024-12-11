//
//  CharacterView.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 30..
//

import SwiftUI

struct CharacterView: View {
    let character: RMCharacter
    
    var body: some View {
        HStack {
            ImageView(imageUrl: character.image)
                .clipShape(Circle())
                .frame(width: 100)
            
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.title2)
                    .fontWeight(.medium)
                
                HStack {
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(character.statusColor)
                    Text(character.status.text)
                        .font(.title3)
                        .fontWeight(.light)
                }
            }
        }
    }
}

#Preview {
    CharacterView(character: RMCharacter.Rick)
}
