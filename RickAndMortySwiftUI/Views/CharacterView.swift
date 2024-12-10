//
//  CharacterView.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 30..
//

import SwiftUI

struct CharacterView: View {
    @State var image: UIImage? = nil
    let character: RMCharacter
    var statusColor: Color {
        switch character.status {
        case .alive:
                .green
        case .dead:
                .red
        case .unknown:
                .yellow
        }
    }
    
    var body: some View {
        HStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 100)
            } else {
                Image(.avatar)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 100)
            }
            
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.title2)
                    .fontWeight(.medium)
                
                HStack {
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(statusColor)
                    Text(character.status.text)
                        .font(.title3)
                        .fontWeight(.light)
                }
            }
        }
        .task {
            self.image = await NetworkManager.shared.downloadImage(from: character.image)
        }
    }
}

#Preview {
    CharacterView(character: RMCharacter.Rick)
}
