//
//  EpisodeListCell.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 30..
//

import SwiftUI

struct EpisodeListCell: View {
    let episode: RMEpisode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(episode.episode)
                .font(.title2)
                .minimumScaleFactor(0.6)
            Text(episode.name)
                .font(.title3)
            Text(episode.airDate)
                .font(.callout)
        }
    }
}

#Preview {
    EpisodeListCell(episode: RMEpisode.test_episode)
}
