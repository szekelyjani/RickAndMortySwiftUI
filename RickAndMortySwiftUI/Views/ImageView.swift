//
//  ImageView.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 12. 11..
//

import SwiftUI

struct ImageView: View {
    @State var image: UIImage?
    let imageUrl: String
    
    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(.avatar)
                    .resizable()
                    .scaledToFill()
            }
        }
        .task {
            image = await NetworkManager.shared.downloadImage(from: imageUrl)
        }
    }
        
}

#Preview {
    ImageView(imageUrl: RMCharacter.Rick.image)
}
